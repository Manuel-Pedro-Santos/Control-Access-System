import isel.leic.utils.Time
import java.util.*

class App {
    fun accessMech() {
        var uinCode = ""
        var pinCode = ""
        while(true) {
            if (M().isOn())
                manut()
            uinCode = TUI().writeUin(TUI().currentTime())
            if(uinCode.length == 3)
                pinCode = TUI().writePin("",5000)
            if(pinCode.length == 4)
                break
        }
        val (name, message) = checkFileForUser(uinCode.toInt(), pinCode)
        val open = authenticated(name, message, uinCode, TUI().currentTime())
        if (open) {
            newRegister(name,uinCode, TUI().currentTime())
            TUI().openingDoor()
            DoorMechanism().open(0x07)
            while (DoorMechanism().finished());
            TUI().openDoor()
            TUI().closingDoor()
            DoorMechanism().close(0x07)
            while (DoorMechanism().finished());
            TUI().closeDoor()
        }
    }
    private fun authenticated(name: String, message: String, uinCode: String, date: String):Boolean {
        if (name.isNotEmpty()) {
            TUI().writeAutentic("Hello ", name)
            val key = TUI().waitKey(2000)
            if (key == '#') {
                changePin(uinCode.toInt())
            }
            if (message.isNotEmpty()) {
                TUI().writeMessage(message)
                val key = TUI().waitKey(2000)
                if (key == '*') {
                    TUI().clearMessage()
                }
                if (key == '#') {
                    changePin(uinCode.toInt())
                }
            }
            TUI().writeName(name)
            return true
        } else {
            TUI().LoginFail("Login Failed")
            return false
        }
    }

    private fun manut() {
        TUI().writeAutentic("Out of service", "Wait ")
        var over = false
        println("Turn M key to off to terminate the maintenance mode")
        println("Commands: NEW, DEL, MSG, or OFF")
        var command: String? = null
        while (true) {
            print("Maintenance> ")
            command = readlnOrNull()?.uppercase()
            if (M().isOff()) {
                println("Exiting maintenance mode...")
                break
            }
            when (command) {
                "NEW" -> {
                    print("User name? ")
                    val name = readln()
                    print("PIN? ")
                    val pin = readln()
                    val value = addUser(name, pin)
                    println("Adding user $value: $name")
                }
                "DEL" -> {
                    print("UIN? ")
                    val uin = readln().toInt()
                    removeUser(uin)
                    println("User removed")
                }
                "MSG" -> {
                    print("UIN? ")
                    val uin = readln().toInt()
                    val message = checkMessage(uin)
                    if(message.isNotEmpty()) {
                        println("User has this message: $message ")
                        print("Remove this message Y/N?")
                        val answer = readln().uppercase(Locale.getDefault())
                        if (answer == "N") {
                            println("Command aborted")
                            continue
                        }
                    }
                    print("Message? ")
                    val newMessage = readln()
                    substituteMessage(uin,newMessage)
                }
                "OFF" -> {
                    over = true
                    break
                }
                else -> {
                    println("Invalid command. Please enter NEW, DEL, MSG, or OFF.")
                }
            }
        }
        if (over) {
            writeUsers
            writeLOG
            Time.sleep(1000)
            System.exit(0)
        }
    }
    fun changePin(uin:Int) {
        TUI().writeAutentic("Change PIN", "(YES = *)")
        val key = TUI().waitKey(2000)
        if (key == '*') {
            var pin = ""
            var pinConfirm = ""
            pin = TUI().writePin("Insert new" , 5000)
            pinConfirm = TUI().writePin("Re-insert new" , 5000)
            if(pin == pinConfirm){
                changePinInFIle(uin,pin)
                TUI().writeAutentic("PIN has been", "changed", 2000)//writeKeyMsg("PIN has been", " changed")
            }
            else{
                TUI().writeAutentic("PIN has been","helded", 2000)//writeKeyMsg("  PIN has been","    helded")
            }
        }else{
            TUI().writeAutentic("PIN has been","helded", 2000)//.writeKeyMsg("  PIN has been","    helded")
        }
    }
}
fun main() {

    HAL.init()
    KBD().init()
    LCD().init()
    SerialEmitter().init()
    DoorMechanism().init()
    val app = App()
    while (true) {
        app.accessMech()
    }
}
