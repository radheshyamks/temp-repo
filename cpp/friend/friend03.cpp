#include <iostream>
class B;
class A{
	private:
		int i;
	public:
		A(int);
		~A();
		void set(int);
		void print();
		friend void fun(A, B);
};
A::A(int k): i{k}{std::cout<<"This is class A constructor\n";}
A::~A(){std::cout<<"This is class A destructor\n";}
void A::set(int k){
	this->i = k;
}
void A::print(){
	std::cout<<"i = "<<i<<std::endl;
}
class B{
	private:
		int j;
	public:
		B(int);
		~B();
		void set(int);
		void print();
		friend void fun(A, B);
};
B::B(int k): j{k}{std::cout<<"This is class B constructor\n";}
B::~B(){std::cout<<"This is class B destructor\n";}
void B::set(int k){
	this->j = k;
}
void B::print(){
	std::cout<<"j = "<<j<<std::endl;
}
void fun(A obj1, B obj2){
	int k;
	k = obj1.i + obj2.j;
	std::cout<<"k = "<<k<<std::endl;
}
int main(int argc, char* argv[], char** env){
	A obj1(10);
	B obj2(30);
	fun(obj1, obj2);
	return 0;
}
