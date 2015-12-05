import std.stdio;

void main()
{
    uint count = 0;
    uint count2 = 0;
    foreach(word; stdin.byLine())
    {
        if(word.hasAtleast(3, "aeiou") && word.hasDouble() && word.doesNotContain(["ab","cd","pq","xy"]))
        {
            count++;
        }
        if(word.hasDoubleTwice() && word.hasDoubleBetween())
        {
            count2++;
        }
    }
    writeln(count);
    writeln(count2);
}

bool hasAtleast(char[] word, uint count, string chars)
{
    foreach(c; word)
    {
        foreach(s; chars)
        {
            if(c == s)
            {
                count--;
                if(count == 0)
                {
                    return true;
                }
            }
        }
    }
    return false;
}

bool hasDouble(char[] word)
{
    for(int i = 0; i < word.length - 1; i++)
    {
        if(word[i] == word[i + 1])
        {
            return true;
        }
    }
    return false;
}

bool doesNotContain(char[] word, char[2][] list)
{
    foreach(item; list)
    {
        for(int i = 0; i < word.length - 2; i++)
        {
            if(word[i..i+2] == item)
            {
                return false;
            }
        }
    }
    return true;
}

bool hasDoubleTwice(char[] word)
{
    for(int i = 0; i < word.length - 1; i++)
    {
        auto pair = word[i..i+2];
        for(int j = i + 2; j < word.length - 1; j++)
        {
            if(j != i && j != i + 1)
            {
                if(word[j..j+2] == pair)
                {
                    return true;
                }
            }
        }
    }
    return false;
}

bool hasDoubleBetween(char[] word)
{
    for(int i = 0; i < word.length - 2; i++)
    {
        if(word[i] == word[i + 2])
        {
            return true;
        }
    }
    return false;
}
