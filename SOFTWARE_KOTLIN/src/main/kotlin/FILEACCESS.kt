import java.io.File


fun writeFileUSERS(arr:MutableList<USERS>){
    val file = File("USERS1.txt")
    val array = arr.sortedBy { it.uin }
    file.bufferedWriter().use { out ->
        for (i in array.indices) {
            out.write("${array[i].uin};${array[i].pin};${array[i].name};${array[i].message};")
            out.newLine()
        }
    }
}

fun writeFileLOG(arr:MutableList<LOG>) {
    val file = File("LOG1.txt")
    file.bufferedWriter().use { out ->
        for (i in arr.indices) {
            out.write("UIN:${arr[i].uin} | NAME:${arr[i].name} | DATE/TIME:${arr[i].dateTime};")
            out.newLine()
        }
    }
}

fun readFile(): MutableList<USERS> {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines()
    val arr = mutableListOf<USERS>()
    for (line in lines) {
        val tokens = line.split(";")
        if (tokens.size >= 3) {
            val user = USERS(tokens[0].toInt(), tokens[1], tokens[2], tokens[3])
            arr.add(user)
        }
    }
    return arr
}


/*
fun checkMessage(uin: Int): String {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines()
    for (line in lines) {
        val tokens = line.split(";")
        if (tokens.isNotEmpty() && tokens[0].trim() == uin.toString()) {
            return tokens[3].trim()
        }
    }
    return ""
}

fun substituteMessage(uin: Int, message: String) {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines().toMutableList()
    for (i in 0 until lines.size) {
        val tokens = lines[i].split(";")
        if (tokens.isNotEmpty() && tokens[0].trim() == uin.toString()) {
            lines[i] = "$uin;${tokens[1]};${tokens[2]};$message;"
            break
        }
    }
    file.bufferedWriter().use { writer ->
        for (line in lines) {
            writer.write(line)
            writer.newLine()
        }
    }
}

fun newRegister(name:String,uin: String, dateTime: String) {
    val file = File("LOG1.txt")
    val lines = file.bufferedReader().readLines().toMutableList()
    val newLine = "UIN: $uin | NAME: $name | DATE/TIME: $dateTime"
    lines.add(newLine)
    file.bufferedWriter().use { writer ->
        for (line in lines) {
            writer.write(line)
            writer.newLine()
        }
    }
}

fun checkFileForUser(uin: Int, pin:String): Pair<String, String>{
    val file = BufferedReader(FileReader("USERS1.txt"))
    val lines = file.readLines()
    for (line in lines) {
        val tokens = line.split(";")
        if (tokens.size >= 3) {
            val uinFile = tokens[0].trim()
            val pinFile = tokens[1].trim()
            if (uin.toString() == uinFile && pin == pinFile) {
                return tokens[2].trim() to tokens[3].trim()
            }
        }
    }
    return "" to ""
}
fun addUser(name: String, pin: String): Int {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines().toMutableList()
    val uin = lines.size + 1
    val newLine = "$uin; $pin; $name;"
    lines.add(newLine)
    file.bufferedWriter().use { writer ->
        for (line in lines) {
            writer.write(line)
            writer.newLine()
        }
    }
    return uin
}
fun removeUser(uin: Int) {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines().toMutableList()

    lines.removeIf { line ->
        val tokens = line.split(";")
        tokens.isNotEmpty() && tokens[0].trim() == uin.toString()
    }
    file.bufferedWriter().use { writer ->
        for (line in lines) {
            writer.write(line)
            writer.newLine()
        }
    }
}
fun changePin(uin: Int,pin: String) {
    val file = File("USERS1.txt")
    val lines = file.bufferedReader().readLines().toMutableList()

    for (i in 0 until lines.size) {
        val tokens = lines[i].split(";")
        if (tokens.isNotEmpty() && tokens[0].trim() == uin.toString()) {
            lines[i] = "${tokens[0]};$pin;${tokens[2]};${tokens[3]};"
            break
        }
    }
    file.bufferedWriter().use { writer ->
        for (line in lines) {
            writer.write(line)
            writer.newLine()
        }
    }
}*/