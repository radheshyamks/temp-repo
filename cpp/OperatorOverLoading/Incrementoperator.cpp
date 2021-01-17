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
		A operator++();
		A operator++(int);
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
A A::operator++()
{
	A temp;
	temp.x = ++x;
	temp.y = ++y;
	return temp;
}
A A::operator++(int)
{
	A temp;
	temp.x = x++;
	temp.y = y++;
	return temp;
}
int main(int argc, char* argv[], char** env)
{
	A obj1(1, 2);
	//A obj2 = obj1.operator++();
	A obj2 = ++obj1;
	obj1.print();
	obj2.print();
	obj2 = obj1++;
	obj1.print();
	obj2.print();
	return 0;
}
