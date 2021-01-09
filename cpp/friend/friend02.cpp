#include <iostream>
class A{
	private:
		int x;
	public:
		A(int =0);
		~A();
		void set(int);
		void print();
		friend void fun(A);
};
A::A(int k):x{k}{std::cout<<"this is class A construcotor\n";}
A::~A(){std::cout<<"This is destructor\n";}
void A::set(int t){
	this->x = t;
}
void A::print(){
	std::cout<<"x = "<<x<<std::endl;
}
void fun(A obj){
	std::cout<<"obj.x = "<<obj.x<<std::endl;
}
int main(int argc, char* argv[], char** env){
	A obj;
	fun(obj);
	return 0;
}
