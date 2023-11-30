
class DoorMechanism { // Controla o estado do mecanismo de abertura da porta.
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init(){
        SerialEmitter().init()
        DoorMechanism().close(0x07)
        while (finished());
    }
    // Envia comando para abrir a porta, com o parâmetro de velocidade
    fun open(velocity: Int) {
        val OC = 1
        val data = OC or (velocity shl   1)
        SerialEmitter().send(SerialEmitter.Destination.DOOR, data)
    }
    // Envia comando para fechar a porta, com o parâmetro de velocidade
    fun close(velocity: Int) {
        val OC = 0
        val data = OC or (velocity shl 1)
        SerialEmitter().send(SerialEmitter.Destination.DOOR, data)
    }
    // Verifica se o comando anterior está concluído
    fun finished(): Boolean = SerialEmitter().isBusy()
}

fun main() {
    DoorMechanism().init()
    DoorMechanism().open(0x02)
    while (DoorMechanism().finished());
    DoorMechanism().close(0x02)
    while (DoorMechanism().finished());
}