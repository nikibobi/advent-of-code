import std.stdio;
import std.conv;

void main()
{
    auto target = to!int(stdin.byLine().front);
    writeln(partOne(target));
    writeln(partTwo(target));
}

size_t partOne(uint target)
{
    auto n = target / 10;
    auto houses = new uint[n];
    for(uint elf = 1; elf < n; elf++)
    {
        for(uint house = elf; house < n; house += elf)
        {
            houses[house] += elf * 10;
        }
    }
    return findMinIndex(houses, target);
}

size_t partTwo(uint target)
{
    auto n = target / 11;
    auto houses = new uint[n];
    for(uint elf = 1; elf < n; elf++)
    {
        for(uint house = elf; house < n && house < elf * 50; house += elf)
        {
            houses[house] += elf * 11;
        }
    }
    return findMinIndex(houses, target);
}

size_t findMinIndex(uint[] houses, uint target)
{
    foreach(i, presents; houses)
    {
        if(presents >= target)
        {
            return i;
        }
    }
    return -1;
}
