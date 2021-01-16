#include <iostream>
class A{
	private:
		int a;
	public:
		A(int =0);
		~A();
		void setval(int);
		void print();
};
A::A(int k): a{k}{std::cout<<"this is class A constructor\n";}
A::~A(){std::cout<<"this is class A destructor\n";}
void A::setval(int t)
{
	this->a = t;
}
void print()
{
	std::cout<<"a = "<<this->a<<std::endl;
}
class B: public A{
	private:
		int b;
	public:
		B(int =0);
		~B();
		void Setval(int);
		void Print();
};
B::B(int k): a{k}{std::cout<<"this is class B constructor\n";}
B::~B(){std::cout<<"this is class B destructor\n";}
void B::Setval(int t){
	this->b = t;
}
void B::Print(){
	std::cout<<"b = "<<this->b<<std::endl;
}
int main(int argc, char* argv[])
{
	A obj1(5), obj2(1);
	A *Aptr1, *Aptr2;
	B objb1(10), objb2(20);
	return 0;
}
