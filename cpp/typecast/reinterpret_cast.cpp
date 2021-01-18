#include <iostream>
struct A{
	char x;
	int i;
	float f;
};
int main(int argc, char* argv[], char** env)
{
	A s = {'A', 10, 2.1234f};
	char *ch = reinterpret_cast<char*>(&s);
	std::cout<<"s.x = "<<*ch<<std::endl;
	int* i = reinterpret_cast<int*>(ch+4);
	std::cout<<"s.i = "<<*i<<std::endl;
	float* f = reinterpret_cast<float*>(++i);
	std::cout<<"s.f = "<<*f<<std::endl;
	return 0;
}
