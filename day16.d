import std.stdio;
import std.conv : to;
import std.array : split;

void main()
{
    int[string] aunt = ["children":3,"cats":7,"samoyeds":2,"pomeranians":3,"akitas":0,"vizslas":0,"goldfish":5,"trees":3,"cars":2,"perfumes":1];
    int id;
    foreach(line; stdin.byLine())
    {
        auto sp = line.split();
        if(matchingAunt(aunt, sp))
        {
            id = to!int(sp[1]);
            break;
        }
    }
    writeln(id);
}

bool matchingAunt(int[string] aunt, char[][] data)
{
    for(int i = 2; i < 8; i += 2)
    {
        string key = to!string(data[i]);
        int value = to!int(data[i + 1]);
        if(key == "cats" || key == "trees")
        {
            if(!(value > aunt[key]))
            {
                return false;
            }
        }
        else if(key == "pomeranians" || key == "goldfish")
        {
            if(!(value < aunt[key]))
            {
                return false;
            }
        }
        else
        {
            if(value != aunt[key])
            {
                return false;
            }
        }
    }
    return true;
}
