import std.stdio;
import std.conv : to;
import std.array : split, array;
import std.algorithm;
import std.range;

void main()
{
    int[][] ings =
    stdin
    .byLine
    .map!split
    .map!(sp => iota(2, 10 + 1, 2)
                .map!(i => to!int(sp[i]))
                .array)
    .array;

    enum ingsMax = 100;
    auto scoreMax = int.min;
    foreach(a; 0..ingsMax+1)
    {
        foreach(b; 0..ingsMax+1-a)
        {
            foreach(c; 0..ingsMax+1-a-b)
            {
                foreach(d; 0..ingsMax+1-a-b-c)
                {
                    auto scores = new int[ings[0].length];
                    for(int i = 0; i < scores.length; i++)
                    {
                        scores[i] += a * ings[0][i];
                        scores[i] += b * ings[1][i];
                        scores[i] += c * ings[2][i];
                        scores[i] += d * ings[3][i];
                        scores[i] = max(0, scores[i]);
                    }
                    if(scores[$ - 1] == 500)
                    {
                        auto score = reduce!((a, b) => a * b)(1, scores[0..$ - 1]);
                        if(score > scoreMax)
                        {
                            scoreMax = score;
                        }
                    }
                }
            }
        }
    }
    writeln(scoreMax);
}
