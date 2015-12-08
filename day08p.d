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
        //line = line[1..$-1]; //don't shorten it
        int count = 0;
        for(int i = 0; i < line.length; i++)
        {
            if(line[i] == '\\' || line[i] == '"')
            {
                count++;
            }
            count++;
        }
        count += 2; //for quotes
        memCount += count;
    }
    writeln(memCount - charCount);
}