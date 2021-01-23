class User:
    def __init__(self, __name):
        self.name= __name
        print("this is constructor")
    def Name(self, __name, __subname):
        print( __name, __subname)

user1 = User("Radheshyam")
user1.Name("Radheshyam", "kamar")
