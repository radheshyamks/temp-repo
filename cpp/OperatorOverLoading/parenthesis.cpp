#include <iostream>
class A{
	private:
		int x;
	public:
		A(int =0);
		~A();
		void setval(int=0);
		void print();
		A operator()();
};
A::A(int k):x{k}{std::cout<<"this is destructor"<<std::endl;}
A::~A(){std::cout<<"this is destructor"<<std::endl;}
void A::setval(int k)
{
	this->x = k;
}
void A::print()
{
	std::cout<<"x = "<<x<<std::endl;
	std::cout<<"this is print function"<<std::endl;
}
A A::operator()()
{
	std::cout<<"this is operator overloading"<<std::endl;
	A temp;
	temp.x = x; 
	return temp;
}
int main(int argc, char* argv[], char** env)
{
	A obj(100);
	A obj1 = obj();
	obj1.print();
	return 0;
}
