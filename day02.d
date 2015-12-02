import std.stdio;
import std.algorithm : min;
import std.conv : to;
import std.array : split;

void main()
{
	long paper = 0;
	long ribbon = 0;
	foreach(line; stdin.byLine())
	{
		auto s = split(line, "x");
		auto w = to!int(s[0]);
		auto h = to!int(s[1]);
		auto d = to!int(s[2]);
		int s1 = w * h;
		int s2 = h * d;
		int s3 = d * w;
		paper += 2 * (s1 + s2 + s3) + min(s1, s2, s3);
		int p1 = 2 * (w + h);
		int p2 = 2 * (h + d);
		int p3 = 2 * (d + w);
		ribbon += min(p1, p2, p3) + (w * h * d);
	}
	writeln("paper: ", paper);
	writeln("ribbon: ", ribbon);
}
