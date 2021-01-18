#this program can add natural number
def function(Int):
    if(Int==1 or Int==0):
        return Int;
    else:
        return Int+function(Int-1)


i = int(input("Enter an Integer: "))
if(i>=0):
    k = function(i)
    print("addition of", i,"natural number is", k)
else:
    print("There will be different program for -ve number")
