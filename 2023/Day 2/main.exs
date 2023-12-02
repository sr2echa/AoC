content = File.read!("input.txt")
games = String.trim(content) |> String.split("\n")

sigma_id = Enum.reduce(games, 0, fn game, acc ->
  [id, data] = String.split(game, ": ")
  id = String.split(id, " ") |> Enum.at(1) |> String.to_integer()
  sets = data
          |> String.split("; ")
          |> Enum.map(fn set ->
            set
            |> String.split(", ")
            |> Enum.reduce(%{"red" => 0, "green" => 0, "blue" => 0}, fn cube, acc ->
              [num, color] = String.split(cube, " ")
              Map.update!(acc, color, &(&1 + String.to_integer(num)))
            end)
          end)

  possible = Enum.all?(sets, fn set ->
    set["red"] <= 12 && set["green"] <= 13 && set["blue"] <= 14
  end)

  if possible, do: acc + id, else: acc
end)

sigma_pow = Enum.reduce(games, 0, fn game, acc ->
  [_bla, data] = String.split(game, ": ")
  min_cubes = Enum.reduce(String.split(data, "; "), %{"red" => 0, "green" => 0, "blue" => 0}, fn set, acc ->
    Enum.reduce(String.split(set, ", "), acc, fn cube, acc ->
      [num, color] = String.split(cube, " ")
      max_count = max(acc[color], String.to_integer(num))
      Map.put(acc, color, max_count)
    end)
  end)
  power = min_cubes["red"] * min_cubes["green"] * min_cubes["blue"]
  acc + power
end)

IO.puts("Part 1: #{sigma_id}")
IO.puts("Part 2: #{sigma_pow}")
