#include <iostream>
#include <reference.hh>
using namespace std;
int main(int argc, char* argv[], char** env)
{
	int x=10;
	int &y = x;
	y++;
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
	std::cout<<"Major version "<<MAJOR_VERSION<<std::endl<<"Minor version "<<MINOR_VERSION<<std::endl;
	return 0;
}
