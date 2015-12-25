import std.stdio : readln, writeln;
import std.conv : to;
import std.string : strip;

void main()
{
    enum start = 20151125UL;
    enum mul = 252533UL;
    enum mod = 33554393UL;
    auto row = readln().strip().to!uint();
    auto col = readln().strip().to!uint();
    ulong number = start;
    for(size_t r = 1, c = 1; r != row || c != col; r--, c++)
    {
        //writefln("[%s,%s] = %s", r, c, number);
        number = (number * mul) % mod;
        if(r == 1)
        {
            r = c + 2;
            c = 0;
        }
    }
    writeln(number);
}
