=begin

These are the core set of rules. It's recommended that you do not tamper with
these, as they provide the basic functionality for MaBE. If you want to create
new rules, please add them to under the "▼ Mars Battle Engine Custom Rules"
section.

=== RULES ===
See each rule for more detailed explanations.

	* do <n>
	    Executes the <n>th action.
	* if <condition> then <action>
	    If <condition> returns anything other than nil, then <action> is run.
	* goto <n>
	    Jumps to the <n>th line. This MAY NOT WORK YET!

=== EXAMPLES ===
Note that all of these examples assume that you have NOT tampered with the
core ruleset.

A most basic example is
	<Mars> do 0

If you add this to the notes field of an enemy, then MaBE will cause the enemy
to execute the first action available to it.

Note that I didn't say "The first action," but "The first action available to
it." In RMVX Ace, you can give conditions for each attack (e.g. enemy only has
50% HP remaining). If the attack is not available normally in RMVX Ace, then it
will NOT be able to be used by MaBE. When designing enemies, I recommend making
all attacks' conditions be set to "Always," as this will simplify design.

It's important to note that, if you do something totally invalid like
	<Mars> do -100

MaBE will NOT crash, but it WILL dump a warning to the log. MaBE will then
happily continue to the next line. If there are no valid lines at all, MaBE
will fallback to RMVX Ace's action selection code. Whenever this happens, MaBE
will print a warning to the log.


On to the next example:
	<Mars-Config>
	if do 10 then do 1
	do 0
	<Mars-End-Config>

If "do 10" succeeds (i.e. there are 11 actions available), then "do 1" is
executed (i.e. 2nd action is used). If the first line does not result int a
valid action, then "do 0" is used.

This is a rather contrived example. I will provide a better one once conditional
expressions are created.

=end