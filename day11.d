import std.stdio;
import std.string;
import std.conv : to;

void main()
{
	string pass = readln().chomp();
	writeln(pass.nextPass);
	writeln(pass.nextPass.nextPass);
}

string nextPass(string pass)
{
	while(true)
	{
		pass = increment(pass);
		if(pass.increasingChars(3) &&
		   pass.notContain(['i','o','l']) &&
		   pass.hasPairs(2))
		{
			return pass;
		}
	}
}

string increment(string str)
{
	char[] res = str.dup;
	int i = res.length - 1;
	while(res[i] == 'z')
	{
		res[i] = 'a';
		i--;
	}
	res[i]++;
	return to!string(res);
}

bool increasingChars(string str, int count)
{
	for(int i = 0; i < str.length - count + 1; i++)
	{
		int c = 1;
		while(i + 1 < str.length && str[i + 1] - str[i] == 1)
		{
			c++;
			i++;
		}
		if(c >= count)
		{
			return true;
		}
	}
	return false;
}

bool notContain(string str, char[] chars)
{
	foreach(ch; chars)
	{
		if(indexOf(str, ch) != -1)
		{
			return false;
		}
	}
	return true;
}

bool hasPairs(string str, int count)
{
	int pairs = 0;
	for(int i = 0; i < str.length - 1; i++)
	{
		if(str[i] == str[i + 1])
		{
			pairs++;
			i++;
		}
		if(pairs >= count)
		{
			return true;
		}
	}
	return false;
}
