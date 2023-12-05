data = open("input.txt").read().strip()
parts = data.split('\n\n')
seed = [int(x) for x in parts[0].split(':')[1].split()]
L = []

for i in parts[1:]:
    t = [[int(x) for x in line.split()] for line in i.split('\n')[1:]]
    L.append(t)

# Part 1
P1 = []
for x in seed:
    for t in L:
      for d, s, sz in t:
          if s <= x < s + sz:
            x = x + d - s
            break
    P1.append(x)
print(f"Part 1: {min(P1)}")

# Part 2
P2 = []
pairs = list(zip(seed[::2], seed[1::2]))
for st, sz in pairs:
    R = [(st, st + sz)]
    for t in L:
        A = []
        for d, s, sz in t:
            sEnd = s + sz
            NR = []
            while R:
                st, ed = R.pop()
                before = (st, min(ed, s))
                mid = (max(st, s), min(sEnd, ed))
                after = (max(sEnd, st), ed)
                if before[1] > before[0] :NR.append(before)
                if mid[1] > mid[0]       :A.append((mid[0] - s + d, mid[1] - s + d))
                if after[1] > after[0]   :NR.append(after)
            R = NR
        R = A + R
    P2.append(min(R)[0])
print(f"Part 2: {min(P2)}")