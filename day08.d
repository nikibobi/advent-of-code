import std.stdio;
import std.string;

void main()
{
    int charCount = 0;
    int memCount = 0;
    foreach(line; stdin.byLine())
    {
        line = chomp(line);
        assert(line[0] == '"');
        assert(line[$-1] == '"');
        charCount += line.length;
        line = line[1..$-1];
        int count = 0;
        for(int i = 0; i < line.length; i++)
        {
            if(line[i] == '\\')
            {
                if(line[i+1] == '\\')
                {
                    i++;
                }
                else if(line[i+1] == '"')
                {
                    i++;
                }
                else if(line[i+1] == 'x')
                {
                    i += 3;
                }
            }
            count++;
        }
        memCount += count;
    }
    writeln(charCount - memCount);
}
