import std.stdio;
import std.array : split;
import std.conv : to;
import std.algorithm : max, map, reduce, each, filter;

class Raindeer
{
    static Raindeer create(char[] line)
    {
        auto spl = split(line);
        auto name = to!string(spl[0]);
        auto speed = to!int(spl[3]);
        auto flyTime = to!int(spl[6]);
        auto restTime = to!int(spl[13]);
        return new Raindeer(name, speed, flyTime, restTime);
    }

    this(string name, int speed, int flyTime, int restTime)
    {
        this.name = name;
        this.speed = speed;
        this.flyTime = flyTime;
        this.restTime = restTime;
        this.distance = 0;
        this.time = 0;
        this.points = 0;
    }

    void step()
    {
        if(time < flyTime)
        {
            distance += speed;
        }
        time = (time + 1) % (flyTime + restTime);
    }

    immutable string name;
    immutable int speed;
    immutable int flyTime;
    immutable int restTime;
    int distance;
    int time;
    int points;
}

void main()
{
    enum seconds = 2503;
    Raindeer[] deers;
    foreach(line; stdin.byLine())
    {
        deers ~= Raindeer.create(line);
    }

    foreach(i; 0..seconds)
    {
        deers.each!(d => d.step());
        auto m = deers.map!(d => d.distance).reduce!max;
        deers.filter!(d => d.distance == m).each!(d => d.points++);
    }

    deers.map!(d => d.distance).reduce!max.writeln; //part1
    deers.map!(d => d.points).reduce!max.writeln; //part2
}
