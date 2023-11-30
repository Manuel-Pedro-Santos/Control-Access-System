import java.util.*

class M {
    val MANUTENCAO_MASK =0x40
    fun isOn(): Boolean {
        return HAL.isBit(MANUTENCAO_MASK)
    }
    fun isOff(): Boolean {
        return !isOn()
    }
}