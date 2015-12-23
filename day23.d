import std.stdio;
import std.conv;
import std.array;
import std.algorithm;

void main()
{
    uint[string] regs = ["a": 0, "b": 0];
    auto instrs = stdin.byLine.map!(to!string).array;
    for(int i = 0; i >= 0 && i < instrs.length; )
    {
        char[3] inst = instrs[i][0..3];
        string[] args = instrs[i][3..$].to!string.split;
        switch(inst)
        {
            case "hlf":
                regs[args[0]] >>= 1;
                i++;
                break;
            case "tpl":
                regs[args[0]] *= 3;
                i++;
                break;
            case "inc":
                regs[args[0]]++;
                i++;
                break;
            case "jmp":
                i += args[0].to!int;
                break;
            case "jie":
                if((regs[args[0]] & 1) == 0)
                {
                    i += args[1].to!int;
                }
                else
                {
                    i++;
                }
                break;
            case "jio":
                if(regs[args[0]] == 1)
                {
                    i += args[1].to!int;
                }
                else
                {
                    i++;
                }
                break;
            default:
                writeln(inst);
                i++;
                break;
        }
    }
    writeln(regs["b"]);
}
