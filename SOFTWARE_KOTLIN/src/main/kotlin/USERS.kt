data class USERS(
    val uin: Int,
    val pin: String,
    val name: String,
    val message: String
)

const val MAXUSERS = 1000
val users = readFile()




fun checkMessage(uin: Int): String{
    for (i in users.indices) {
        if (users[i].uin == uin) {
            return users[i].message
        }
    }
    return ""
}

fun checkFileForUser(uin: Int, pin:String): Pair<String, String> {
    for (i in users.indices) {
        if (users[i].uin == uin && users[i].pin == pin) {
            return users[i].name to users[i].message
        }
    }
    return "" to ""
}

fun  addUser(name: String, pin: String):Int{
    //var flag = false
    if(users.size == MAXUSERS)return -1
    val sortedUINs = users.map { it.uin }.sorted()
    var newUIN = 0
    for (i in sortedUINs.indices) {
        if (sortedUINs[i] != i ) {
            newUIN = i
            users.add(USERS(newUIN, pin, name, ""))
            //flag = true
            return newUIN
        }
    }
    users.add(USERS(sortedUINs.size, pin, name, ""))
    return sortedUINs.size
}



fun removeUser(uin: Int){
    for (i in users.indices) {
        if (users[i].uin == uin) {
            users.removeAt(i)
            break
        }
    }
}

fun changePinInFIle(uin: Int,pin: String) {
    for (i in users.indices) {
        if (users[i].uin == uin) {
            users[i] = USERS(users[i].uin, pin, users[i].name, users[i].message)
            break
        }
    }
}

fun substituteMessage(uin: Int, message: String) {
    for (i in users.indices) {
        if (users[i].uin == uin) {
            users[i] = USERS(users[i].uin, users[i].pin, users[i].name, message)
            break
        }
    }
}

