#include <iostream>
#include <functional>
/* syntax
 * std::function<ret(args)>fptr = [capture list](argumnets)->return{//code}*/
int main(int argc, char* argv[], char** env)
{
    std::function<int(void)>fptr = [](void)->int{std::cout<<"This is labda function\n"; return 10;};
    int x = fptr();
    std::cout<<"x = "<<x<<std::endl;
    return 0;
}
