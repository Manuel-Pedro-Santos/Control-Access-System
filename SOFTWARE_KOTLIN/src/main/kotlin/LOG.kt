
data class LOG(
    val uin: Int,
    val name: String,
    val dateTime: String
)
val log = emptyList<LOG>().toMutableList()

val writeUsers = writeFileUSERS(users)
val writeLOG = writeFileLOG(log)

fun newRegister(name:String,uin: String, dateTime: String) {
    val newLine = LOG(uin.toInt(), name, dateTime)
    log.add(newLine)
}