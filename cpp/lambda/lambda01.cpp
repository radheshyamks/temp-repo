#include <iostream>
#include <functional>
int main(int argc, char* argv[])
{
    std::function<void(void)>fptr = [](void)->void{std::cout<<"This is labda function\n"; return;};
    fptr();
    return 0;
}
