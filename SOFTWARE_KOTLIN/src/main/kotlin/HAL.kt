import isel.leic.UsbPort


// Virtualiza o acesso ao sistema UsbPort
object HAL {

    private var lastWriting = 0x00
    // private val listSingleBits = listOf(0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80)

    // Inicia a classe
    fun init() {
        UsbPort.write(lastWriting)
    }

    // Retorna os valores dos bits representados por mask presentes no UsbPort
    fun readBits(mask: Int): Int = mask and UsbPort.read()

    // Retorna true se o bit tiver o valor lógico ‘1’
    fun isBit(mask: Int): Boolean {
        return (readBits(mask) and mask) != 0
    }

    // Coloca os bits representados por mask no valor lógico ‘1’
    fun setBits(mask: Int) {
        writeBits(mask, 0xFF)
    }

    // Coloca os bits representados por mask no valor lógico ‘0’
    fun clearBits(mask: Int) {
        writeBits(mask, 0x00)
    }


    // Escreve nos bits representados por mask o valor de value
    fun writeBits(mask: Int, value: Int) {
        val a = mask and value
        val b = mask.inv() and lastWriting
        val c = a or b
        UsbPort.write(c)
        lastWriting = c
    }
}

fun main() {
    while (true) {
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
        // UsbPort.write(value)
    }
}