import std.stdio;
import std.conv : to;
import std.string : chomp;
import std.digest.md;

void main()
{
	ulong number = 0;
	string key = readln().chomp();
	//writeln("bosakmaw1268061".md5Of.toHexString);
	while(true)
	{
		string test = key ~ to!string(number);
		auto md5 = md5Of(test);
		auto result = toHexString(md5);
		if(result[0..6] == "000000")
		{
			break;
		}
		number++;
	}
	writeln(number);
}
