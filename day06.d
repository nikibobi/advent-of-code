import std.stdio;
import std.string;
import std.conv;
import std.algorithm;

void main()
{
    // can't make a static array that big
    ulong[][] brightnes = new ulong[][1000];
    for(int i = 0; i < brightnes.length; i++)
    {
        brightnes[i] = new ulong[1000];
        for(int j = 0; j < brightnes[i].length; j++)
        {
            brightnes[i][j] = 0;
        }
    }
    bool[1000][1000] lights;
    foreach(line; stdin.byLine())
    {
        line = chompPrefix(line, "turn");
        auto s = split(line);
        assert(s.length == 4);

        auto p0 = split(s[1], ",");
        assert(s[2] == "through");
        auto p1 = split(s[3], ",");

        auto x0 = to!uint(p0[0]);
        auto y0 = to!uint(p0[1]);
        auto x1 = to!uint(p1[0]);
        auto y1 = to!uint(p1[1]);

        for(size_t y = y0; y <= y1; y++)
        {
            for(size_t x = x0; x <= x1; x++)
            {
                if(s[0] == "on")
                {
                    lights[y][x] = true;
                    brightnes[y][x] += 1;
                }
                else if(s[0] == "off")
                {
                    lights[y][x] = false;

                    // this is somehow wrong
                    /*brightnes[y][x] -= 1;
                    if(brightnes[y][x] < 0)
                        brightnes[y][x] = 0;*/

                    if(brightnes[y][x] > 0)
                        brightnes[y][x] -= 1;
                }
                else if(s[0] == "toggle")
                {
                    lights[y][x] = !lights[y][x];
                    brightnes[y][x] += 2;
                }
                else
                {
                    writeln(s[0]);
                }
            }
        }
    }
    auto countOn = lights[].map!(a => a[].sum).sum;
    auto countBrightness = brightnes.map!(a => a.sum).sum;
    writeln(countOn);
    writeln(countBrightness);
}
