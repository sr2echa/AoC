import java.io.File

fun main() {
    val lines = File("input.txt").readLines()

    var total1 = 0
    for (r in lines.indices) {
        var c = 0
        while (c < lines[r].length) {
            if (lines[r][c].isDigit()) {
                var end = c
                while (end < lines[r].length && lines[r][end].isDigit()) {
                    end++
                }
                val num = lines[r].substring(c, end).toInt()
                if ((c until end).any { isAdjacent(lines, r, it) }) {
                    total1 += num
                }
                c = end
            } else {
                c++
            }
        }
    }

    println("Part 1: $total1")

    var total2 = 0
    for ((row, line) in lines.withIndex()) {
        for ((col, char) in line.withIndex()) {
            if (char != '*') continue

            val s = mutableSetOf<Pair<Int, Int>>()

            for (x in row - 1..row + 1) {
                for (y in col - 1..col + 1) {
                    var newY = y
                    if (x !in lines.indices || newY !in lines[x].indices || !lines[x][newY].isDigit()) continue
                    while (newY > 0 && lines[x][newY - 1].isDigit()) {
                        newY--
                    }
                    s.add(Pair(x, newY))
                }
            }

            if (s.size != 2) continue

            val nums = s.map { (x, y) ->
                generateSequence(y) { it + 1 }
                    .takeWhile { it < lines[x].length && lines[x][it].isDigit() }
                    .joinToString("") { lines[x][it].toString() }
                    .toInt()
            }

            total2 += nums[0] * nums[1]
        }
    }

    println("Part 2: $total2")
}

fun isAdjacent(grid: List<String>, r: Int, c: Int): Boolean {
    val directions = listOf(
        -1 to -1, -1 to 0, -1 to 1, 
         0 to -1,  0 to 1, 
         1 to -1,  1 to 0,  1 to 1
    )

    for ((dr, dc) in directions) {
        val nr = r + dr
        val nc = c + dc
        if (nr in grid.indices && nc in grid[0].indices && grid[nr][nc] !in '0'..'9' && grid[nr][nc] != '.') {
            return true
        }
    }
    return false
}
