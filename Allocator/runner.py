import pywasm
import sys 

plotPoints = {}
"""
This function records an x and y value for a certain variable
This will be used inside the wasm code to report metrics like runtime, memory expansions, etc.
For simplicity, varName is actually a number, and will be mapped like this:
0 - runtime
1 - # of memory expansions
2 - total heap size
3 - average memory free when expanding
"""
def logdata(varName, varVal):
	print(f"Data received: {varName}, {varVal}")
	plotPoints[varName] = varVal

def printNum(x):
	print(x, end="")

def printLn():
	print()

def readNum():
	return int(input("Enter a number: "))

env = {
'write': printNum,
'writeln': printLn,
'read': readNum,
'logdata': logdata
}

if len(sys.argv) != 2:
	print("Usage: runner.py <.wasm file>")
	sys.exit(1)
vm = pywasm.load(sys.argv[1], {"P0lib":env, "env":env})
# Debug code
# print(vm.exec('malloc',[1])) # Should malloc to 0
# print(vm.exec('malloc',[10])) # Should malloc to 4 + 1 = 5
# print(vm.exec('malloc', [1])) # Should malloc to 5 + 4 + 10 = 19
# print(vm.exec('malloc', [10])) # Should malloc to 19 + 4 + 1 = 24
# vm.exec('free', [5])
# print(vm.exec('malloc', [1])) # Should malloc to 5 again
# print(vm.exec('malloc', [1])) # Should malloc to 5 + 4 + 1 = 10 
# print(vm.exec('malloc', [10])) # Should malloc to 24 + 10 + 4 = 38
# vm.exec('free',[0])
# print(vm.exec('malloc', [10])) # Should malloc to 38 + 10 + 4 = 52
# print(vm.exec('malloc', [1])) # Should malloc to 0

# Super smart BF debug code
print(vm.exec('malloc',[4])) # 0
print(vm.exec('malloc',[4])) # 8
print(vm.exec("malloc", [4])) # 16
print(vm.exec('malloc', [4])) # 24
print(vm.exec('malloc',[4])) # 32
print(vm.exec('malloc', [4])) # 40
print(vm.exec('malloc',[4])) # 48
vm.exec('free',[0])
vm.exec('free',[8])
vm.exec('free',[16])
vm.exec('free',[32])
vm.exec('free', [40])
# Next expecteds are ff/bf
print(vm.exec('malloc',[4])) #0/32
print(vm.exec('malloc',[4])) #8/40
print(vm.exec('malloc',[20])) #56/0
# Edn debug code
# TODO: Make some way to automate this through an automatic test runner
print(plotPoints)
