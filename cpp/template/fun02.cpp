#include <iostream>
template<typename T1, typename T2>
class A{
	private:
		T1 x,y;
		T2 z, t;
	public:
		A(T1, T1, T2, T2);
		~A();
		void setval(T1, T1, T2, T2);
		void print();
};
template<typename T1, typename T2>
A<T1, T2>::A(T1 a, T1 b, T2 c, T2 d ): x{a}, y{b}, z{c}, t{d}{std::cout<<"this is class A constructor"<<std::endl;}
template<typename T1, typename T2>
A<T1, T2>::~A(){std::cout<<"this is class A destructor"<<std::endl;}
template<typename T1, typename T2>
void A<T1, T2>::setval(T1 i, T1 j, T2 k, T2 l)
{
	this->x = i;
	this->y = j;
	this->z = k;
	this->t = l;
}
template<typename T1, typename T2>
void A<T1, T2>::print()
{
	std::cout<<"x = "<<this->x<<std::endl;
	std::cout<<"y = "<<this->y<<std::endl;
	std::cout<<"z = "<<this->z<<std::endl;
	std::cout<<"t = "<<this->t<<std::endl;
}
int main(int argc, char* argv[], char** env)
{
	A<int, float>obj(10, 10, 12.123f, 20.126f);
	obj.setval(20, 30, 10.254f, 60.153f);
	obj.print();
	A<std::string, std::string>objs("Radheshyam", "Siwan", "Bihar", "India");
	objs.setval("radheshyam", "siwan", "bihar", "india");
	objs.print();
	return 0;
}
