/* -> there are three types of pointer
 * 1. unique_ptr
 * 2. share_ptr
 * 3. weak_ptr
 * */
#include <iostream>
class abc{
	private:
		int* data;
	public:
		abc(int *ptr= nullptr): data{ptr}{std::cout<<"this is constructor"<<std::endl;}
		~abc(){delete data; std::cout<<"this is destructor"<<std::endl;}
		int& operator* (){
			std::cout<<"this is overloaded function"<<std::endl;
			return *data;
		}
};
int main()
{
	int* ptr = new int(100);
	//abc obj = abc(ptr);
	abc obj(ptr);
	std::cout<<"after calling constructor"<<std::endl;
	std::cout<<"value obj = "<< *obj<<std::endl;
	std::cout<<"*ptr = "<<*ptr<<std::endl;
	return 0;
}
