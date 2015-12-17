import std.stdio;
import std.conv : to;
import std.algorithm : map, sort, sum, filter, reduce, min;
import std.array;
import std.range : iota;

void main()
{
    enum target = 150;
    auto numbers = stdin.byLine.map!(to!int).array.sort;
    auto res = sumCombos(numbers, target);
    iota(0, numbers.length).map!(n => res[target][n]).sum.writeln;
    res[target][iota(0, numbers.length).filter!(n => res[target][n] != 0).reduce!min].writeln;
}

int[][] sumCombos(int[] numbers, int target)
{
    int[][] counts = new int[][target + 1];
    foreach(ref count; counts)
    {
        count = new int[numbers.length + 1];
    }
    counts[0][0] = 1;
    foreach(size; numbers)
    {
        for(int v = target - size; v >= 0; v--)
        {
            for(int n = numbers.length; n > 0; n--)
            {
                counts[v + size][n] += counts[v][n - 1];
            }
        }
    }
    return counts;
}
