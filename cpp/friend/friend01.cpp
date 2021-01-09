#include <iostream>
using namespace std;
class B;
class A{
	private:
		int x, y;
	public:
		A(int =0, int =0);
		~A();
		void setval(int =0, int =0);
		void print(B);
};
A::A(int s, int t): x{s}, y{t}{std::cout<<"This is class A constructor\n";}
A::~A(){std::cout<<"class A destructor\n";}
void A::setval(int j, int k){
	this->x = j;
	this->y = k;
}
void A::print(B objB){
	std::cout<<"x = "<<x<<std::endl;
	std::cout<<"y = "<<y<<std::endl;
	std::cout<<"objB.k = "<<objB.k<<std::endl;
}
class B{
	private:
		int k;
		float f;
	public:
		friend class A;
		B(int =0, float =0.0f);
		~B();
		void Setval(int =0, float =0.0f);
		void Print();
};
B::B(int i, float j): k{i}, f{j}{std::cout<<"this is class B constructor\n";}
B::~B(){std::cout<<"this is class B destructor\n";}
void B::Setval(int i, float j){
	this->k = i;
	this->f = j;
}
void B::Print(){
	std::cout<<"k = "<<k<<std::endl;
	std::cout<<"f = "<<f<<std::endl;
}
int main(int argc, char* argv[], char** env)
{
	B obj;
	A objA(10, 20);
	objA.setval(1, 5);
	objA.print(obj);
	//objA.B::Setval(10, 30.0f);
	return 0;
}
