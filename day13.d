import std.stdio;
import std.algorithm.searching : canFind;
import std.algorithm.sorting : nextPermutation;
import std.array : split;
import std.conv : to;

void main()
{
    string[] people;
    int[string][string] hashmap;
    foreach(line; stdin.byLine())
    {
        auto sp = split(line);
        assert(sp.length == 11);

        auto person1 = to!string(sp[0]);
        assert(sp[1] == "would");
        assert(sp[2] == "lose" || sp[2] == "gain");
        auto happiness = to!int(sp[3]) * (sp[2] == "gain" ? 1 : -1);
        assert(sp[4] == "happiness");
        assert(sp[5] == "units");
        assert(sp[6] == "by");
        assert(sp[7] == "sitting");
        assert(sp[8] == "next");
        assert(sp[9] == "to");
        auto person2 = to!string(sp[10][0..$-1]);

        if(!people.canFind(person1))
        {
            people ~= person1;
        }
        if(!people.canFind(person2))
        {
            people ~= person2;
        }

        hashmap[person1][person2] = happiness;
    }

    //part 2
    // string me = "Bosak";
    // foreach(person; people)
    // {
    //     hashmap[me][person] = 0;
    //     hashmap[person][me] = 0;
    // }
    // people ~= me;

    int maxHappiness = int.min;
    string[] maxOrder;
    do
    {
        int happiness = getHappiness(people, hashmap);

        if(happiness > maxHappiness)
        {
            maxHappiness = happiness;
            maxOrder = people.dup;
        }

    }while(nextPermutation(people));

    writeln(maxHappiness, " -> ", maxOrder);
}

int getHappiness(string[] people, int[string][string] hashmap)
{
    int happiness = 0;
    happiness += hashmap[people[0]][people[$ - 1]] + hashmap[people[0]][people[1]];
    for(int i = 1; i < people.length - 1; i++)
    {
        happiness += hashmap[people[i]][people[i - 1]] + hashmap[people[i]][people[i + 1]];
    }
    happiness += hashmap[people[$ - 1]][people[$ - 2]] + hashmap[people[$ - 1]][people[0]];
    return happiness;
}
