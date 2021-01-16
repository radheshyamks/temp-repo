guess_nu=0
key=10
guess_cnt=1
print("you've to guess a number")
print("you can guess maximum 5 times")
while guess_cnt<=5:
    #print("Guess: ")
    guess_nu=int(input("Guess number: "))
    if(guess_nu == 10):
        #print("Congrates")
        #print("You Won!")
        break
    else:
        print("oop's wrong guess!")
    guess_cnt+=1
if(guess_nu == 10):
    print("Congrates")
    print("You Won!")
else:
    print("Sorry you failed!")
