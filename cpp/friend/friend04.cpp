#include <iostream>
class B{
	private:
		int b;
		friend class A;
	public:
		B(int =0);
		~B();
		void setval(int);
		void print();
};
B::B(int k): b{k}{std::cout<<"this is class B constructor\n";}
B::~B(){std::cout<<"this is class B constructor\n";}
void B::setval(int x){
	b = x;
}
void B::print(){
	std::cout<<"b = "<<b<<std::endl;
}
class A{
	private:
		int a;
	public:
		A(int =0);
		~A();
		void setval(B);
		void print();
};
A::A(int i): a{i}{std::cout<<"this is class A constructor\n";}
A::~A(){std::cout<<"this is class A destructor"<<std::endl;}
void A::setval(B obj){
	a = obj.b;
}
void A::print()
{
	std::cout<<"a = "<<a<<std::endl;
}
int main(int argc, char* argv[])
{
	B objB(10);
	A objA(20);
	objA.setval(objB);
	objA.print();
	return 0;
}
