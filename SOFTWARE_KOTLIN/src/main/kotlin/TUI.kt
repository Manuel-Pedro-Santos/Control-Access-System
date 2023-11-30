import isel.leic.utils.Time
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class TUI {
    private var i = 4
    var uinCode = ""
    var pinCode = ""
    val lcd = LCD()

    fun writeUin(date: String): String{
        LCD().clear()
        LCD().write(date)
        LCD().cursor(1, 0)
        LCD().write("UIN:???")
        i = 4
        while (true) {
            LCD().cursor(1, i)
            val uin = waitKey(10000)
            if(uin == '#')
                continue
            if(uin == '*') {
                i = 4
                LCD().clearLine(1)
                LCD().cursor(1, 0)
                LCD().write("UIN:???")
                uinCode = ""
                continue
            }
            if (uin != 0.toChar()) {
                LCD().write(uin)
                uinCode += uin
                i += 1
                if (i == 7) {
                    break
                }
            }
            else break
        }
        return uinCode
    }

    fun writePin(label:String,timeout: Long = 2000): String {
        if(label != ""){
            LCD().clear()
            LCD().write(label)
        }
        LCD().clearLine(1)
        LCD().cursor(1, 0)
        LCD().write("PIN:????")
        i = 4
        while (true) {
            LCD().cursor(1, i)
            val pin = waitKey(timeout)
            if(pin == '#')
                continue
            if(pin == '*') {
                if(pinCode.isEmpty()) {
                    LoginFail("Login Failed")
                    break
                }
                i = 4
                LCD().clearLine(1)
                LCD().cursor(1, 0)
                LCD().write("PIN:????")
                pinCode = ""
                continue
            }
            if (pin != 0.toChar()) {
                LCD().write('*')
                pinCode += pin
                i += 1
                if (i == 8) {
                    break
                }
            }
            else{
                LoginFail("Login Failed")
                break
            }
        }
        return pinCode
    }

    fun openingDoor() {
        LCD().cursor(1, 0)
        LCD().write(" openig Door...")
    }
    fun openDoor(){
        LCD().clearLine(1)
        LCD().write("  Door opened")
        Time.sleep(3000)
    }
    fun closingDoor(){
        LCD().clearLine(1)
        LCD().write(" closing Door...")
    }
    fun closeDoor(){
        LCD().clearLine(1)
        LCD().write("  Door closed")
        Time.sleep(3000)
        LCD().clear()
    }

    fun clearMessage() {
        LCD().clear()
        LCD().cursor(0, 0)
        LCD().write("  Clear Msg.?")
        LCD().cursor(1, 0)
        LCD().write("   (YES = *)")
        val key = KBD().waitKey(4000)

        if (key == '*') {
            LCD().clear()
            LCD().write("  Msg has been")
            LCD().cursor(1, 0)
            LCD().write("   cleared")
            Time.sleep(2000)
            LCD().clear()
        } else {
            LCD().clear()
            LCD().write("  Msg has been")
            LCD().cursor(1, 0)
            LCD().write("  kept")
            Time.sleep(2000)
            LCD().clear()
        }
    }

    fun writeAutentic(label:String, name:String, timeout: Long = 0){
        LCD().clear()
        writeNameCenter(label,0)
        LCD().cursor(1, 0)
        writeNameCenter(name, 1)
        if(timeout != 0.toLong()){
            Time.sleep(2000)
        }
    }

    fun waitKey(timeout: Long):Char{
        return KBD().waitKey(timeout)
    }

    fun writeName(name:String){
        LCD().clear()
        writeNameCenter(name, 0)
    }

    fun LoginFail(name:String){
        LCD().clearLine(1)
        writeNameCenter(name,1)
        Time.sleep(2000)
        LCD().clear()
    }

    fun writeNameCenter(name: String, line:Int ){
        LCD().cursor(line, 16/2 - name.length/2)
        LCD().write(name)
    }

    fun writeMessage(message: String) {
        LCD().clear()
        LCD().cursor(0, 0)
        if(message.length > 16){
            LCD().write(message.substring(0,16))
            LCD().cursor(1, 0)
            LCD().write(message.substring(16))
        } else {
            LCD().write(message)
        }
    }

    fun currentTime(): String {
        val formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY HH:mm")
        val currentDateTime = LocalDateTime.now()
        return currentDateTime.format(formatter)
    }
}