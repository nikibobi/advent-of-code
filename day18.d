import std.stdio;
import std.array;
import std.algorithm;

void main()
{
    enum times = 100;
    bool[][] lights = stdin.byLine.map!(l => l.map!(c => c == '#').array).array;
    //corners(lights);
    foreach(_; 0..times)
    {
        step(lights);
        //corners(lights);
    }
    writeln(lights.map!sum.sum);
}

void print(bool[][] lights)
{
    foreach(line; lights)
    {
        foreach(light; line)
        {
            write(light ? '#' : '.');
        }
        writeln();
    }
    writeln();
}

void corners(bool[][] lights)
{
    lights[0][0] = true;
    lights[0][$ - 1] = true;
    lights[$ - 1][0] = true;
    lights[$ - 1][$ - 1] = true;
}

void step(bool[][] lights)
{
    auto counts = countOn(lights);
    for(int y = 0; y < lights.length; y++)
    {
        for(int x = 0; x < lights[y].length; x++)
        {
            auto count = counts[y][x];
            lights[y][x] = lights[y][x] ? (count == 2 || count == 3) : (count == 3);
        }
    }
}

int[][] countOn(bool[][] lights)
{
    auto counts = new int[][lights.length];
    for(int y = 0; y < lights.length; y++)
    {
        counts[y] = new int[lights[y].length];
        for(int x = 0; x < lights[y].length; x++)
        {
            counts[y][x] = neigbours(x, y, lights);
        }
    }
    return counts;
}

int neigbours(int x, int y, bool[][] lights)
{
    int lx = lights[y].length;
    int ly = lights.length;
    int count = 0;

    if(x + 1 < lx && lights[y][x + 1])
    {
        count++;
    }
    if(x - 1 >= 0 && lights[y][x - 1])
    {
        count++;
    }
    if(y + 1 < ly && lights[y + 1][x])
    {
        count++;
    }
    if(y - 1 >= 0 && lights[y - 1][x])
    {
        count++;
    }
    if(y + 1 < ly && x + 1 < lx && lights[y + 1][x + 1])
    {
        count++;
    }
    if(y + 1 < ly && x - 1 >= 0 && lights[y + 1][x - 1])
    {
        count++;
    }
    if(y - 1 >= 0 && x + 1 < lx && lights[y - 1][x + 1])
    {
        count++;
    }
    if(y - 1 >= 0 && x - 1 >= 0 && lights[y - 1][x - 1])
    {
        count++;
    }
    return count;
}
