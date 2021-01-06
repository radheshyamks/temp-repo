#include <iostream>
#include <functional>
/* syntax
 * std::function<ret(args)>fptr = [&](argumnets)->return{//code}
 * & -> taking the reference of all local variable
 * */
int main(int argc, char* argv[], char** env)
{
    int k=10, t=20;
    std::function<int(void)>fptr = [&](void)->int{std::cout<<"This is labda function\n"; return ++k*++t*10;};
    int x = fptr();
    std::cout<<"x = "<<x<<std::endl;
    return 0;
}
