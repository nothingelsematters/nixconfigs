fun getVersions(path: String): Map<String, List<String>> = Runtime
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
    .groupBy(List<String>::component1, List<String>::component2)

fun main(args: Array<String>) {

    fun String.colorized(color: String) = "\u001B[${color}m$this\u001B[m"

    if (args.size != 2) {
        println("usage: <old> <new>")
        return
    }

    val (old, new) = args.map(::getVersions)

    val dropped = mutableListOf<String>()
    val expanded = mutableListOf<String>()
    val shrinked = mutableListOf<String>()

    old.forEach { (key, oldVersions) ->
        val newVersions = new[key]

        if (oldVersions == newVersions) return@forEach

        if (newVersions == null) {
            dropped.add(key)
            return@forEach
        }

        if (newVersions.size > oldVersions.size) {
            expanded.add(key)
            return@forEach
        }

        if (newVersions.size < oldVersions.size) {
            shrinked.add(key)
            return@forEach
        }

        oldVersions
            .asSequence()
            .sorted()
            .zip(newVersions.asSequence().sorted())
            .filter { (oldVersion, newVersion) -> oldVersion != newVersion }
            .forEach { (oldVersion, newVersion) ->
                val lcp = newVersion.commonPrefixWith(oldVersion)

                println("$key " + ("$lcp: ${oldVersion.substring(lcp.length)} -> " +
                    newVersion.substring(lcp.length)).colorized("0;36"))
            }
    }
    dropped.forEach { println("☠️ $it".colorized("0;31")) }
    expanded.forEach { println("📈 $it".colorized("0;31")) }
    shrinked.forEach { println("📉 $it".colorized("0;31")) }
    new.keys.minus(old.keys).forEach { println("🆕 $it".colorized("0;32")) }
}
