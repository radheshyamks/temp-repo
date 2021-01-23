class abc:
    def __init__(self, name):
        self.name = name
        print("this is construcor")
    def Name(self, n1, n2):
        print(n1, n2)

obj = abc("radheshyam")
obj.Name("radheshyam", "kumar")
