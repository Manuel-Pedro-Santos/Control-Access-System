import isel.leic.utils.Time

class KBD { // Ler teclas. Métodos retornam ‘0’..’9’,’#’,’*’ ou NONE.

    private val NONE = 0
    private val arr = arrayListOf('1', '4', '7', '*', '2', '5', '8', '0', '3', '6', '9', '#')
    private val FOUR_BITS = 0x0F
    private val DVAL_MASK = 0x10
    private val ACK_MASK = 0x01

    // Inicia a classe
    fun init() { HAL.init()
        HAL.clearBits(ACK_MASK)
    }

    // Retorna de imediato a tecla premida ou NONE se não há tecla premida.
    fun getKey(): Char {
        var value = NONE.toChar()
        if (HAL.isBit(DVAL_MASK) ) {
            if(HAL.readBits(FOUR_BITS) in arr.indices)
                 value = arr[HAL.readBits(FOUR_BITS)]
            HAL.setBits(ACK_MASK)
            while (HAL.isBit(DVAL_MASK));
            HAL.clearBits(ACK_MASK)
            return value
        }
        return value
    }

    // Retorna a tecla premida, caso ocorra antes do ‘timeout’
    // (representado em milissegundos),ou NONE caso contrário.
    fun waitKey(timeout: Long): Char {
        val start = Time.getTimeInMillis()
        while (Time.getTimeInMillis() - start < timeout) {
            val key = getKey()
            if (key != NONE.toChar()) {
                return key
            }
        }
        return NONE.toChar()
    }
}

fun main() {
    KBD().init()

    //Testing KDB using waitKey
    while (true) {
        val key = KBD().waitKey(2000)
        if (key != 0.toChar()) {
            println(key)
        } else {
            print(".")
        }
    }
}
