#syntax to call function in python from another file
#from filename_without_extention import fun1, fun2, fun3
#from file_name import *
# * means you're importing all the facility
#from test import * #function(__var)
from test import function
def main(__var):
    print("value of __var is ", __var)
    function(__var)


__var = int(input("enter the value: ",))
main(__var)
