## Main Game
The game has a number of items that can be easily made by inheriting from existing scenes.
You can easily make new scenes based on them by inherting from them and editing the result.

1. World
2. Enemy
3. NPC
4. Wielded Item
5. Effect

### World
The basic level structure handling most logic that must alwas trigger.
New levels inherit from this and mainly require their own TileMap and must be populated with enemies and npc's.

### Enemy
Entities that generally can be hit, killed and make attacks.
They notably require at least their own effects.

### Wielded Item
Items that are equipped and move with the mouse around the player. They are generally weapons and make effects that hit enemies. The effect is added in the linked script.

### Effect
These are generally attack effects with hitboxes. Usually made by Wielded items or enemies. Examples are bullets or whoosh effects from swords.
