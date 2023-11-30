// import isel.leic.UsbPort

fun main(args: Array<String>) {
    /*while (true) {
        val value = UsbPort.read()
        val hal = HAL
        hal.init()
        hal.setBits(value)
        hal.clearBits(0xFF)
        hal.init()
        println(hal.readBits(0xFF))
        val a = hal.isBit(0x02)
        println(a)
        println(hal.readBits(0xFF))
        hal.clearBits(0x0F)
        println(hal.readBits(0xFF))
        hal.writeBits(0x0F, 0x09)
        println(hal.readBits(0xFF))
        // UsbPort.write(value)*/
    /*val kbd = KBD()
    while (true) {
        // kbd.init()
        kbd.getKey()
        println(kbd.getKey())
        kbd.waitKey(10000)
        kbd.getKey()
        println(kbd.getKey())
        kbd.waitKey(10000)
    }*/

    val kbd = KBD()
    kbd.init()

    // Testing KDB using waitKey
    // var key = kdb.waitKey(7000)
    while (true) {
        val key = kbd.waitKey(2000)
        if (key != 0.toChar()) {
            println(key)
        } else {
            print(".")
        }
    }
    // println("Finished")
}