#include<iostream>
using namespace std;
class abc{
    private:
     int a,b;
    public:
     abc(){
        cout<<"default constractor is called.\n";
     }
     void fun(int x, int y){
        a=x;
        b=y;
     }
     void sum(){
        int s=a+b;
        cout<<"Sum of a and b is : "<<s<<endl;
     }
     ~abc(){
        cout<<"destructor is called.\n";
     }
};
int main(){
    abc obj;
    obj.fun(10, 20);
    obj.sum();
}
 