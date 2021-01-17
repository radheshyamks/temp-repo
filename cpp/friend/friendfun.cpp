#include <stdio.h>
#include <iostream>
class B;
class A{
	private:
		int x, y;
	public:
		A(int, int);
		~A();
		void setval(int, int);
		void print();
		friend void fun(A, B);
};
A::A(int a, int b): x{a}, y{b}{std::cout<<"this is class A constructor\n";}
A::~A(){std::cout<<"this is class A destructor"<<std::endl;}
void A::setval(int j, int k)
{
	this->x = j;
	this->y = k;
}
void A::print()
{
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
}
class B{
	private:
		int x, y;
	public:
		B(int, int);
		~B();
		void setval(int, int);
		void print();
		friend void fun(A, B);
};
B::B(int a, int b): x{a}, y{b}{std::cout<<"this is class B constructor\n";}
B::~B(){std::cout<<"this is class B destructor"<<std::endl;}
void B::setval(int j, int k)
{
	this->x = j;
	this->y = k;
}
void B::print()
{
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
}
void fun(A obja, B objb)
{
	int x = obja.x + objb.x;
	int y = obja.y + objb.y;
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
}
int main(int argc, char* argv[], char** env)
{
	A obja(1, 2);
	B objb(3, 4);
	fun(obja, objb);
	return 0;
}
