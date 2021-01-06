#include <iostream>
#include <functional>
/* syntax
 * std::function<ret(args)>fptr = [=, &var](argumnets)->return{//code}
 * &var -> taking all local variable as mutable and var as referece
 * */
int main(int argc, char* argv[], char** env)
{
    int k=10, t=20;
    std::function<int(int)>fptr = [=, &k](int y)->int{std::cout<<"This is labda function\n"; return ++k*t*10*y;};
    int x = fptr(10);
    std::cout<<"x = "<<x<<std::endl;
    return 0;
}
