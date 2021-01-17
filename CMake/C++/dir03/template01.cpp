#include <iostream>
#include <template.hh>
using namespace std;
template<typename T>
void function(T x)
{
	std::cout<<"This is template function"<<std::endl;
	std::cout<<"x = "<<x<<std::endl;
	return;
}
int main(int argc, char* argv[])
{
	function(10);
	function(20.123f);
	std::cout<<"Major VERSION "<<major_version<<std::endl<<"MINOR VERSION "<<minor_version<<std::endl;
	return 0;
}
