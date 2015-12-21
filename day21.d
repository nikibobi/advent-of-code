import std.stdio;
import std.algorithm : max, map;
import std.math : ceil;

class Entity
{
    int health;
    int attack;
    int defence;

    this(int health, int attack, int defence)
    {
        this.health = health;
        this.attack = attack;
        this.defence = defence;
    }

    @property bool dead()
    {
        return health <= 0;
    }

    void equip(Item item)
    {
        this.attack += item.attack;
        this.defence += item.defence;
    }

    void damage(Entity other)
    {
        other.health -= max(1, this.attack - other.defence);
    }

    int turnsToDie(Entity other)
    {
        return cast(int)ceil(this.health / max(1.0, other.attack - this.defence));
    }
}

struct Item
{
    string name;
    uint cost;
    int attack;
    int defence;
}

void main()
{
    auto boss = new Entity(103, 9, 2);
    auto player = new Entity(100, 0, 0);
    auto none = Item("None", 0, 0, 0);
    auto weapons = [
    Item("Dagger", 8, 4, 0),
    Item("Shortsword", 10, 5, 0),
    Item("Warhammer", 25, 6, 0),
    Item("Longsword", 40, 7, 0),
    Item("Greataxe", 74, 8, 0)];
    auto armors = [
    none,
    Item("Leather", 13, 0, 1),
    Item("Chainmail", 31, 0, 2),
    Item("Splintmail", 53, 0, 3),
    Item("Bandedmail", 75, 0, 4),
    Item("Platemail", 102, 0, 5)];
    auto rings = [
    none,
    Item("Damage +1", 25, 1, 0),
    Item("Damage +2", 50, 2, 0),
    Item("Damage +3",100, 3, 0),
    Item("Defense +1", 20, 0, 1),
    Item("Defense +2", 40, 0, 2),
    Item("Defense +3", 80, 0, 3)];
    auto minCost = int.max;
    auto maxCost = int.min;
    Item[] minItems, maxItems;
    foreach(weapon; weapons)
    {
        foreach(armor; armors)
        {
            foreach(ring1; rings)
            {
                foreach(ring2; rings)
                {
                    if((ring1 == none && ring2 == none) || (ring1 != ring2))
                    {
                        int cost = weapon.cost + armor.cost + ring1.cost + ring2.cost;
                        player.attack = weapon.attack + ring1.attack + ring2.attack;
                        player.defence = armor.defence + ring1.defence + ring2.defence;
                        //player wins
                        if(player.turnsToDie(boss) >= boss.turnsToDie(player))
                        {
                            //we spent less gold and still won
                            if(cost < minCost)
                            {
                                minCost = cost;
                                minItems = [weapon, armor, ring1, ring2];
                            }
                        }
                        //boss wins
                        else
                        {
                            //we spent more gold and still lost
                            if(cost > maxCost)
                            {
                                maxCost = cost;
                                maxItems = [weapon, armor, ring1, ring2];
                            }
                        }
                    }
                }
            }
        }
    }
    writeln("min ", minCost, "g -> ", minItems.map!(item => item.name));
    writeln("max ", maxCost, "g -> ", maxItems.map!(item => item.name));
}
