local a = {}
local b = 0
table.insert(a, 11)
table.insert(a, "bar")
b = b+1
print('1'..b)
print(table.concat(a,","))