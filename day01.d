import std.stdio;

void main()
{
    auto line = readln();
    int floor = 0;
    for(int i = 0; i < line.length; i++)
    {
        if(line[i] == '(')
        {
            floor++;
        }
        if(line[i] == ')')
        {
            floor--;
        }

        if(floor == -1)
        {
            writeln(i + 1);
        }
    }
    writeln(floor);
}