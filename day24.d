import std.stdio;
import std.algorithm;
import std.conv;
import std.array;

enum compartments = 4;

Appender!(long[][]) solutions;

void main(string[] args)
{
    auto weights = stdin.byLine.map!(to!long).array.reverse;
    auto weight = weights.sum / compartments;
    solutions = appender!(long[][])();
    sums(weights, weight);
    auto sols = solutions.data;
    //find shortest length
    auto minlen = sols.map!(s => s.length).reduce!min;
    //get all solutions of that length
    auto minsols = sols.filter!(s => s.length == minlen);
    //find all products
    auto prods = minsols.map!(reduce!"a * b");
    //find the smallest product
    auto minprod = prods.reduce!min;
    //find the solution with the smallest product
    auto result = minsols.filter!(s => s.reduce!"a * b" == minprod).front;
    writefln("len: %s prod: %s sol: %s", minlen, minprod, result);
}

void sums(long[] numbers, long target, long[] current = [])
{
    long s = current.sum();
    if(s == target)
    {
        solutions.put(current);
        return;
    }
    if(s > target)
    {
        return;
    }
    for(size_t i = 0; i < numbers.length; i++)
    {
        sums(numbers[i + 1..$], target, current ~ numbers[i]);
    }
}
