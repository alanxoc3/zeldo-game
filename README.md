# That Story About Zeldo
Lank wakes up from a good night's rest only to find Hi-roll in danger! You gotta
help him save the Land of Hi-roll from the forces of evil.

Enjoy my game. Made with <3 in PICO-8.

## String Limitations
Pico-8 is a variant of lua that has its own preprocessor. This game has a perl
script that works as both a custom preprocessor and a lua minifier.

This game also has a function that encodes lua tables in a string. This
function is called "ztable". Ztable has some special rules to it.

Colons and semi colons convert a string to a one layer table. Example:
```
[[a:hello;b:hola;]]
```

Will become this lua table:
```
{
   a="hello",
   b="hola"
}
```

Commas and equal signs add an extra layer to the table. Example:
```
[[a:my=friend,is,cool;123]]
```

Will become this lua table:
```
{
   a={my="friend", "is", "cool"},
   "123"
}
```

A forward slash adds yet an extra layer, but this layer can only hold arrays.
```
[[a:my/sub/array,is=cool;]]
```

Will become this lua table:
```
{
   a={
      {"my","sub","array"},
      is="cool"
   }
}
```

Those are the main symbols that strings could have conflicts with. Other
notable exceptions are these:
- The carrot operator separates screens in the text box system.
- Before the double bracket strings are parsed, pipes are used to separate
  ztables for the create_actor function.
- After the double bracket strings are parsed, pipes are used to separate
  strings that are stored in cartridge data.
- Single quote strings and double bracket strings both mean that there is code
  stored inside the string and the string content can be minified.
- Double quote strings mean that the content is text and therefore should not
  be minified.
- If a double quote string is contained within a double bracket string, the
  text in the double quotes will be preserved, but the double quotes themselves
  will be removed.
- Double bracket strings are all parsed out and put into one massive string
  separated by pipes. This further implies that double bracket strings are
  always used in conjunction with ztable in Zeldo.
- Exclamation marks "!" at the beginning of a value field in ztable means that
  it is a macro that calls a functions from the `_g` table. Parameters are
  separated by forward slashes.
- At signs "@" at the beginning of a field in ztable, followed by a number
  indicates that the value will be replaced with one of the ztable parameters.
  So "@1" will be replaced by the first parameter and so on.

The main limitations with the string system is that text boxes in the game
cannot have any of these characters contained within it: `|":;,=/^`.
