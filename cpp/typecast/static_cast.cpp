#include <iostream>
using namespace std;
int main(int argc, char* argv[])
{
	int k=65;
	char ch = static_cast<char>(k);
	std::cout<<"ch = "<<ch<<std::endl;
	//int *i = static_cast<int*>(&ch);// here is the error, we can't expand the memory size
	//char *c = static_cast<char*>(&k);// this will also throw an error, error: invalid static_cast from type ‘int*’ to type ‘char*’
	return 0;
}
