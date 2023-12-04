cards = readlines("input.txt")

function count(wins, players)
    intersect(wins, players) |> length
end

total = 0
for card in cards
    global total
    _, card_numbers = split(card, ':')
    wins, players = split(card_numbers, '|')
    wins = Set(parse(Int, strip(num)) for num in split(wins))
    players = Set(parse(Int, strip(num)) for num in split(players))

    matches = intersect(wins, players)
    if length(matches) > 0
        points = 1 << (length(matches) - 1)
        total += points
    end
end
println("Part 1: ", total)

parsed = []
for card in cards
    _, card_numbers = split(card, ':')
    wins, players = split(card_numbers, '|')
    wins = Set(parse(Int, strip(num)) for num in split(wins))
    players = Set(parse(Int, strip(num)) for num in split(players))
    push!(parsed, (wins, players))
end

total = length(cards)
c = ones(Int, total)  

for i in 1:total
    matches = count(parsed[i]...)
    for j in i+1:min(i+matches, total)
        c[j] += c[i]
    end
end

println("Part 2: ", sum(c))
