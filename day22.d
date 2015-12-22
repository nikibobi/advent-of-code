import std.stdio;
import std.algorithm;
import std.array;

struct Spell
{
    string name;
    int cost;
    int cooldown;
    void function(int[string], int[string]) action;
    bool instant;
    int duration;
}

void main()
{
    auto boss = ["hp": 51, "attack": 9];
    auto player = ["hp": 50, "armor": 0, "mana": 500];
    auto spells = [
    Spell("Magic Missile", 53, 0, &missle, true),
    Spell("Drain", 73, 0, &drain, true),
    Spell("Shield", 113, 6, &shield),
    Spell("Poison", 173, 6, &poison),
    Spell("Recharge", 229, 5, &recharge)];
    //Magic!
    simulate(player, boss, spells, 0);
    writeln(minMana);
    writeln(minIndexes.map!(i => spells[i].name));
    sim(player, boss, minIndexes.map!(i => spells[i]).array);
}

void sim(int[string] player, int[string] boss, Spell[] spells)
{
    auto used = new Spell[spells.length];
    auto turn = 1;
    foreach(spell; spells)
    {
        writefln("-- Turn %s --", turn++);
        player["hp"] -= 1;
        writeln("Player takes 1 damage");
        foreach(ref effect; used)
        {
            if(effect.duration > 0)
            {
                effect.action(player, boss);
                effect.duration--;
                writeln("Effect " ~ effect.name);
            }
        }
        player["mana"] -= spell.cost;
        spell.duration = spell.cooldown;
        used ~= spell;
        if(spell.instant)
        {
            spell.action(player, boss);
        }
        writeln("Player used " ~ spell.name);
        writeln(player, boss);
        writefln("-- Turn %s --", turn++);
        player["armor"] = 0;
        foreach(ref effect; used)
        {
            if(effect.duration > 0)
            {
                effect.action(player, boss);
                effect.duration--;
                writeln("Effect " ~ effect.name);
            }
        }
        damage(player, boss);
        writeln("Boss attacks Player");
        writeln(player, boss);
        player["armor"] = 0;
    }
}

int minMana = int.max;
size_t[] minIndexes;

void simulate(int[string] p, int[string] b, Spell[] s, int m, size_t[] indexes = [])
{
    foreach(i, spell; s)
    {
        auto state = s.dup;
        auto player = p.dup;
        auto boss = b.dup;
        auto mana = m;
        if(spell.duration != 0 || player["mana"] - spell.cost < 0)
        {
            continue;
        }
        //player turn
        player["hp"] -= 1;
        if(player["hp"] <= 0)
        {
            return;
        }
        foreach(ref effect; state)
        {
            if(effect.duration > 0)
            {
                effect.action(player, boss);
                effect.duration--;
            }
        }
        mana += spell.cost;
        player["mana"] -= spell.cost;
        spell.duration = spell.cooldown;
        if(spell.instant)
        {
            spell.action(player, boss);
        }
        if(boss["hp"] <= 0)
        {
            if(mana < minMana)
            {
                minMana = mana;
                minIndexes = indexes ~ i;
            }
            continue;
        }
        // if(mana > minMana)
        // {
        //     continue;
        // }
        //boss turn
        player["armor"] = 0;
        foreach(ref effect; state)
        {
            if(effect.duration > 0)
            {
                effect.action(player, boss);
                effect.duration--;
            }
        }
        if(boss["hp"] <= 0)
        {
            if(mana < minMana)
            {
                minMana = mana;
                minIndexes = indexes ~ i;
            }
            continue;
        }
        damage(player, boss);
        player["armor"] = 0;
        if(player["hp"] <= 0)
        {
            continue;
        }
        state[i] = spell;
        simulate(player, boss, state, mana, indexes ~ i);
    }
}

void damage(int[string] player, int[string] boss)
{
    player["hp"] -= boss["attack"] - player["armor"];
}

void missle(int[string] player, int[string] boss)
{
    boss["hp"] -= 4;
}

void drain(int[string] player, int[string] boss)
{
    boss["hp"] -= 2;
    player["hp"] += 2;
}

void shield(int[string] player, int[string] boss)
{
    player["armor"] = 7;
}

void poison(int[string] player, int[string] boss)
{
    boss["hp"] -= 3;
}

void recharge(int[string] player, int[string] boss)
{
    player["mana"] += 101;
}
