import std.stdio;
import std.conv : to;
import std.array : appender;
import std.string : chomp;

void main()
{
	string s = readln().chomp();
	for(int i = 0; i < 40; i++)
	{
		s = lookAndSay(s);
	}
	writeln(s.length);
}

string lookAndSay(string str)
{
	auto res = appender!string();
	for(int i = 0; i < str.length; i++)
	{
		int count = 1;
		char ch = str[i];
		while (i + 1 < str.length && str[i + 1] == ch) {
			count++;
			i++;
		}
		res.put(to!string(count));
		res.put(ch);
	}
	return res.data;
}
