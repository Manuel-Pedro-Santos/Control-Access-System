import isel.leic.utils.Time

class LCD {
    private val LINES = 2
    private val COLS = 16 // Dimensão do display.

    private val ENABLE_MASK = 0x40
    private val DATA_MASK = 0x1E
    private val RS_MASK  = 0x20
    private val use_serial_mode = false


    // Escreve um nibble de comando/dados no LCD em paralelo
    private fun writeNibbleParallel(rs: Boolean, data: Int) {
        if (rs)HAL.setBits(RS_MASK) else HAL.clearBits(RS_MASK)
        HAL.setBits(ENABLE_MASK)
        HAL.writeBits(DATA_MASK, data shl 1)
        HAL.clearBits(ENABLE_MASK)
    }

    // Escreve um nibble de comando/dados no LCD em série
    private fun writeNibbleSerial(rs: Boolean, data: Int){
        val rsValue = if(rs) 1 else 0
        val dataFinal = rsValue or (data shl 1)
        SerialEmitter().send(SerialEmitter.Destination.LCD, dataFinal)
        Time.sleep(2)
        /**
         * if(rs) SerialEmitter().send(SerialEmitter.Destination.LCD,1) else SerialEmitter().send(SerialEmitter.Destination.LCD,0)
         * SerialEmitter().send(SerialEmitter.Destination.LCD,data)
         */
    }

    // Escreve um nibble de comando/dados no LCD
    private fun writeNibble(rs: Boolean, data: Int) {
        if (use_serial_mode)
            writeNibbleParallel(rs,data)
        else
            writeNibbleSerial(rs,data)

    }

    // Escreve um ‘byte’ de comando/dados no LCD
    private fun writeByte(rs: Boolean, data: Int) {
        writeNibble(rs, data shr 4) // Write the higher nibble
        writeNibble(rs, data and 0x0F) // Write the lower nibble
    }

    // Escreve um comando no LCD
    private fun writeCMD(data: Int) =  writeByte(false,data)

    // Escreve um dado no LCD
    private fun writeDATA(data: Int) = writeByte(true,data)

    // Envia a sequência de iniciação para comunicação a 4 bits.
    fun init() {
        SerialEmitter().init()
        Time.sleep(50) // Wait for more than 15ms after Vcc rises to 4.5V
        writeNibble(false, 0x03) // Function set: 8-bit interface
        Time.sleep(5) // Wait for more than 4.1ms
        writeNibble(false, 0x03) // Function set: 8-bit interface
        Time.sleep(1) // Wait for more than 100us
        writeNibble(false, 0x03) // Function set: 8-bit interface
        Time.sleep(1) // Wait for more than 100us
        writeNibble(false, 0x02) // Function set: 4-bit interface
        Time.sleep(1) // Wait for more than 100us
        writeCMD(0x28) // Function set: 4-bit interface, 2 lines, 5x8 dots, 40 pontos para cada coluna e depois os 4 bit para referenciar as 16 linhas.
        writeCMD(0x06) // Entry mode set: Increment, no shift
        writeCMD(0x08) // Display on/off control: Display on, cursor off, blink off
        writeCMD(0x0F) // Display on/off control: Display on, cursor off, blink off
        writeCMD(0x01) // Clear display
    }

    // Escreve um caráter na posição corrente.
    fun write(c: Char) = writeDATA(c.hashCode())

    // Escreve uma ‘string’ na posição corrente.
    fun write(text: String) {
        for(c in text){
            write(c)
        }
    }

    // Envia comando para posicionar cursor (‘line’:0..LINES-1 , ‘column’:0..COLS-1)
    fun cursor(line: Int, column: Int) =
        writeCMD((line * (COLS*4) + column) or (LINES *(COLS*4)))


    // Envia comando para limpar o ecrã e posicionar o cursor em (0,0)
    fun clear() {
        writeCMD(1)
        cursor(0,0)
    }

    fun clearLine(line:Int) {
        cursor(line,0)
        for (i in 0 until COLS) write(' ')
        cursor(line,0)
    }
}

fun main(){
    HAL.init()
   LCD().init()
    LCD().write("BEM-VINDO")
    LCD().cursor(1,2)
    LCD().write("ISEL")
    LCD().cursor(0,15)
    LCD().write("A")
}