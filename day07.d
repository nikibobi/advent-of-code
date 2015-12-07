import std.stdio;
import std.string;
import std.conv;

string[string] hash;

void main()
{
    foreach(line; stdin.byLine())
    {
        auto sp = split(line, " -> ");
        hash[to!string(sp[1])] = to!string(sp[0]);
    }
    //hash["b"] = "956"; // for part 2
    writeln(getValue("a"));
}

ushort getValue(string key)
{
    if(key !in hash)
    {
        return to!ushort(key);
    }
    auto sp = split(hash[key]);

    if(sp.length == 1)
    {
        return getValue(sp[0]);
    }
    else if(sp.length == 2)
    {
        if(sp[0] == "NOT")
        {
            ushort value = getValue(sp[1]);
            ushort result = ~value;
            hash[key] = to!string(result);
            return result;
        }
        else
        {
            assert(0);
        }
    }
    else if(sp.length == 3)
    {
        ushort left = getValue(sp[0]);
        ushort right = getValue(sp[2]);
        ushort result;
        if(sp[1] == "AND")
        {
            result = cast(ushort)(left & right);
        }
        else if(sp[1] == "OR")
        {
            result = cast(ushort)(left | right);
        }
        else if(sp[1] == "LSHIFT")
        {
            result = cast(ushort)(left << right);
        }
        else if(sp[1] == "RSHIFT")
        {
            result = cast(ushort)(left >> right);
        }
        else
        {
            assert(0);
        }
        hash[key] = to!string(result);
        return result;
    }
    assert(0);
}
