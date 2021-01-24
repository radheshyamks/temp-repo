/*
 * std::unique_ptr<T> = std::make_unique(new class_name(args))
 * operation on smart pointer:
 * 1. release
 * 2. reset
 * 3. swap
 * 4. move
 * 5. get
 * */
#include <iostream>
#include <memory>
#include <stdlib.h>
#include <stdio.h>
class abc{
	private:
		int k;
	public:
		explicit abc(int =0);
		~abc();
		void setval(int =0);
		void print(void);
};
abc::abc(int t): k{t}{std::cout<<"this is construtor"<<std::endl;}
abc::~abc(){std::cout<<"this is destructor"<<std::endl;}
void abc::setval(int t){
	this->k = t;
}
void abc::print(){
	std::cout<<"k = "<<k<<std::endl;
}
int main()
{
	std::unique_ptr<abc>ptr = std::make_unique<abc>(20);
	ptr->setval(30);
	ptr->print();
	return 0;
}
