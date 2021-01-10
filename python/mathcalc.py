print("Enter two number")
x1 = int(input("Enter first number: "))
x2 = int(input("Enter second number: "))
string = input("Enter your calc choice i.e. add, sub, mul, div and pow: ")
if(string == "add"):
    print("addition of",x1, "and", x2, "is", x1+x2)
elif(string == "sub"):
    print("subtracton of",x1, "and", x2, "is", x1-x2)
elif(string == "mul"):
    print("multiplication of",x1, "and", x2, "is", x1*x2)
elif(string == "div"):
    if(x2 == 0):
        print("invalid division")
    else:
        print("division of",x1, "and", x2, "is", x1/x2)
elif(string == "pow"):
    if((x1==0 ) and (x1==0)):
        print("Invalid power")
    elif(x2>=1000 and x1>=100):
        print("Too large number")
    else:
        print(x1, "power", x2, "is", x1**x2)
else:
    PASS
