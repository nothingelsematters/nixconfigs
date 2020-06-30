fun getVersions(path: String): Map<String, String> = Runtime
    .getRuntime()
    .exec(
        arrayOf(
            "bash",
            "-c",
            "nix eval --json \"( builtins.map builtins.parseDrvName [ " +
            "$(nix-store -qR $path | jq -R '.[44:] | select(test(\"\\\\d\"))') ])\" " +
            "| jq -r '.[] | select(.version | test(\".+\")) | .name, .version'"
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

    fun String.colorized(color: String) = "\u001B[${color}m$this\u001B[m"

    if (args.size != 2) {
        println("usage: <old> <new>")
        return
    }

    val (old, new) = args.map(::getVersions)

    val dropped = mutableListOf<String>()

    old.forEach forEach@{ (key, oldVersion) ->
        val newVersion = new[key]

        if (oldVersion == newVersion) return@forEach

        if (newVersion == null) {
            dropped.add(key)
            return@forEach
        }

        val lcp = newVersion.commonPrefixWith(oldVersion)

        println("$key " + ("$lcp: ${oldVersion.substring(lcp.length)} -> " +
            newVersion.substring(lcp.length)).colorized("0;36"))
    }
    dropped.forEach { println("☠️ $it".colorized("0;31")) }
    new.keys.minus(old.keys).forEach { println("🆕 $it".colorized("0;32")) }
}
