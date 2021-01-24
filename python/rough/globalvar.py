#Local ->
#Enclosing ->
#Global ->
#Built-in ->

x = "global x"

def test():
    y = "local y"
    global x
    x = "local x"
    print(y)
    print(x)


test()
