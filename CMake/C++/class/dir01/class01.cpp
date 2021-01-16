#include <iostream>
#include <class.hh>
class A{
	private:
		int k;
	public:
		A(int);
		~A();
		void setval(int);
		void print();
};
A::A(int t): k{t}{std::cout<<"this is class A constructor\n";}
A::~A(){std::cout<<"this is class A destructor\n";}
void A::setval(int x){
	this->k = x;
}
void A::print()
{
	std::cout<<"k = "<<k<<std::endl;
}
int main(int argc, char* argv[], char** env){
	A obj(0);
	obj.setval(20);
	obj.print();
	std::cout<<"Major version: "<<major_version<<std::endl<<"Minor version: "<<minor_version<<std::endl;
	return 0;
}
