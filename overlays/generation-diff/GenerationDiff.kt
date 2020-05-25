fun getVersions(path: String): Map<String, String> = Runtime
    .getRuntime()
    .exec(
        arrayOf(
            "bash",
            "-c",
            "nix eval --json \"( builtins.map builtins.parseDrvName [ "
            + "$(nix-store -qR $path | jq -R '.[44:] | select(test(\"\\\\d\"))') ])\" "
            + "| jq -r '.[] | select(.version | test(\".+\")) | .name, .version'"
        )
    )
    .getInputStream()
    .bufferedReader()
    .lineSequence()
    .chunked(2)
    .filter { it.size == 2 }
    .map { (a, b) -> a to b }
    .toMap()

fun main(args: Array<String>) {
    if (args.size != 2) {
        println("usage: <old> <new>")
        return
    }

    val old = getVersions(args[0])
    val new = getVersions(args[1])

    for (key in HashSet(old.keys + new.keys)) {
        val oldVer = old[key]
        val newVer = new[key]
        if (old[key] != new[key]) {
            println("$key: $oldVer -> $newVer")
        }
    }
}
