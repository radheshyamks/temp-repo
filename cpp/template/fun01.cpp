#include <iostream>
template<typename T1, typename T2>
void function(T1 x, T2 y)
{
	std::cout<<"x = "<<x<<std::endl<<"y = "<<y<<std::endl;
}
int main(int argc, char** argv, char** env)
{
	function(10, "radheshyam");
	function('A', 10.1234f);
	function("shyam", "kumar");
	return 0;
}
