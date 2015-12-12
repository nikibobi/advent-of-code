import std.stdio;
import std.json;

void main()
{
    string line = readln();
    auto json = parseJSON(line);
    writeln(getSumFromJSON(json));
}

double getSumFromJSON(JSONValue json)
{
    if(json.type == JSON_TYPE.INTEGER)
    {
        return json.integer;
    }
    else if(json.type == JSON_TYPE.UINTEGER)
    {
        return json.uinteger;
    }
    else if(json.type == JSON_TYPE.FLOAT)
    {
        return json.floating;
    }
    else if(json.type == JSON_TYPE.OBJECT)
    {
        double sum = 0;
        foreach(val; json.object)
        {
            // part two
            // if(val.type == JSON_TYPE.STRING && val.str == "red")
            //     return 0;

            sum += getSumFromJSON(val);
        }
        return sum;
    }
    else if(json.type == JSON_TYPE.ARRAY)
    {
        double sum = 0;
        foreach(val; json.array)
        {
            sum += getSumFromJSON(val);
        }
        return sum;
    }
    else
    {
        return 0;
    }
}
