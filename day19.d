import std.stdio;
import std.array;
import std.conv;
import std.algorithm;
import std.string;

void main()
{
    enum molecule = "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr";
    string[][string] hash;
    string[string] inverse;
    string[] keys;
    foreach(line; stdin.byLine())
    {
        auto sp = line.split(" => ");
        auto key = to!string(sp[0]);
        auto val = to!string(sp[1]);
        hash[key] ~= val;
        inverse[val] = key;
        keys ~= val;
    }

    writeln(partOne(molecule, hash));
    writeln(partTwo(molecule, "e", keys, inverse));
}

int partOne(string molecule, string[][string] hash)
{
    bool[string] different;
    foreach(key; hash.keys)
    {
        foreach(i; indexes(molecule, key))
        {
            foreach(rep; hash[key])
            {
                auto s = molecule.replaceAt(i, key, rep);
                different[s] = true;
            }
        }
    }
    return different.length;
}

int partTwo(string molecule, string target, string[] keys, string[string] hash)
{
    int steps = 0;
    do
    {
        foreach(key; keys)
        {
            if(molecule.canFind(key))
            {
                molecule = molecule.replaceFirst(key, hash[key]);
                steps++;
            }
        }
    }while(molecule != target);
    return steps;
}

string replaceAt(string str, size_t index, string key, string replacement)
{
    auto app = appender!string();
    app.put(str[0..index]);
    app.put(replacement);
    app.put(str[index + key.length..$ - 1]);
    return app.data;
}

size_t[] indexes(string str, string needle)
{
    auto app = appender!(size_t[])();
    size_t index = indexOf(str, needle);
    while(index != -1)
    {
        app.put(index);
        index = indexOf(str, needle, index + 1);
    }
    return app.data;
}
