#include <iostream>
int main(int argc, char* argv[])
{
	/*
	 * const int y=20;
	 * int* ptr1 = &y;
	 * int* ptr = const_cast<int*>(ptr1)
	 * this way of const_cast is not the right way.
	 * */
	int x = 10;
	const int* Cptr = &x;
	int* ptr = const_cast<int*>(Cptr);
	x = 20;
	*ptr = 30;
	std::cout<<"*ptr = "<<*ptr<<std::endl<<"x = "<<x<<std::endl;
	return 0;
}
