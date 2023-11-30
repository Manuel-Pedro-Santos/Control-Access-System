import isel.leic.UsbPort
import isel.leic.utils.Time


class SerialEmitter { // Envia tramas para os diferentes módulos Serial Receiver.

    private val SCLK_MASK = 0x08
    private val SDX_MASK = 0x10
    private val BUSY_MASK = 0x20

    enum class Destination(val sel:Int) {LCD(0x04), DOOR(0x02)}

    // Inicia a classe
    fun init(){
        HAL.init()
        val mask = Destination.LCD.sel or Destination.DOOR.sel or SCLK_MASK or SDX_MASK
        val value = Destination.LCD.sel or Destination.DOOR.sel
        //0001 1110 value 0000 0110
        HAL.writeBits(mask, value)
        /*
        HAL.setBits(Destination.LCD.sel)
        HAL.setBits(Destination.DOOR.sel)
        HAL.clearBits(SCLK_MASK)
        HAL.clearBits(SDX_MASK)
         */
    }

    // Envia uma trama de 5 bits rs e os restantes 4 bits de data para o destino addr
    fun send(addr: Destination, data: Int) {
        HAL.clearBits(addr.sel)
        var trama = data
        for (i in 0..4) {
            HAL.clearBits(SCLK_MASK)
            val sdx = trama and 1
            if (sdx == 1) HAL.setBits(SDX_MASK) else HAL.clearBits(SDX_MASK)
            trama = trama shr 1
            HAL.setBits(SCLK_MASK)
        }
        HAL.clearBits(SDX_MASK)
        HAL.clearBits(SCLK_MASK)
        HAL.setBits(addr.sel)
    }
    // Retorna true se o canal série estiver ocupado
    fun isBusy(): Boolean = HAL.isBit(BUSY_MASK)
}

//00 -> ACK
//01 -> not SDCsel
//02 -> not LCDsel
//03 -> SClk
//04 -> SDX
fun main() {
    SerialEmitter().init()
    for (value in 0x02..0x08) {
        SerialEmitter().send(SerialEmitter.Destination.LCD, value)
    }
}