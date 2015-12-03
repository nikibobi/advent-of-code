import std.stdio;

void main()
{
	auto line = readln();
	ulong count = 0;
	uint[2][2] coords = [[0, 0], [0, 0]];
	bool[uint[2]] hash;

	foreach(i, c; line)
	{
		auto idx = (i % 2);
		uint[2] key = coords[idx];
		if(key !in hash)
		{
			hash[key] = true;
			count++;
		}

		switch(c)
		{
			case '>':
				coords[idx][0]++;
				break;
			case '<':
				coords[idx][0]--;
				break;
			case '^':
				coords[idx][1]++;
				break;
			case 'v':
				coords[idx][1]--;
				break;
			default:
				break;
		}
	}
	writeln(count);
}
