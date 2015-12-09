import std.stdio;
import std.algorithm.searching : canFind;
import std.algorithm.sorting : nextPermutation;
import std.array : split;
import std.conv : to;

void main()
{
    string[] cities;
    int[string][string] hashmap;
    foreach(line; stdin.byLine())
    {
        auto sp = split(line);
        assert(sp.length == 5);

        string city1 = to!string(sp[0]);
        assert(sp[1] == "to");
        string city2 = to!string(sp[2]);
        assert(sp[3] == "=");
        auto distance = to!int(sp[4]);

        if(!cities.canFind(city1))
        {
            cities ~= city1;
        }
        if(!cities.canFind(city2))
        {
            cities ~= city2;
        }

        hashmap[city1][city2] = distance;
        hashmap[city2][city1] = distance;
    }

    int minDist = int.max;
    int maxDist = int.min;
    string[] minPath, maxPath;
    do
    {
        int dist = getDistance(cities, hashmap);

        if(dist < minDist)
        {
            minDist = dist;
            minPath = cities.dup;
        }
        if(dist > maxDist)
        {
            maxDist = dist;
            maxPath = cities.dup;
        }

    }while(nextPermutation(cities));

    writeln(minDist, " -> ", minPath);
    writeln(maxDist, " -> ", maxPath);
}

int getDistance(string[] path, int[string][string] hashmap)
{
    int dist = 0;
    for(int i = 0; i < path.length - 1; i++)
    {
        auto city1 = path[i];
        auto city2 = path[i + 1];
        dist += hashmap[city1][city2];
    }
    return dist;
}
