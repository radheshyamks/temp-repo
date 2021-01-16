#include <iostream>
#include <stdio.h>
class A{
	private:
		int x, y;
	public:
		A(int=0, int=0);
		~A();
		void setval(int, int);
		void print();
		A operator+(A);
};
A::A(int j, int k): x{j}, y{k}{std::cout<<"this is class A constructor"<<std::endl;}
A::~A(){std::cout<<"this is class A destructor"<<std::endl;}
void A::setval(int i, int j)
{
	this->x = i;
	this->y = j;
}
void A::print()
{
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
}
A A::operator+(A obj)
{
	A temp;
	temp.x = x + obj.x;
	temp.y = y + obj.y;
	return temp;
}
int main(int argc, char* argv[], char** env)
{
	A obj1(1, 2), obj2(3, 4);
	A obj3 = obj1.operator+(obj2);
	obj3.print();
	return 0;
}
