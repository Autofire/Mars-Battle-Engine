=begin
Author: Autofire
Version: 0.1

	Mars Battle Engine

	This script enables greater control over how enemies behave in RPG Maker VX
Ace. It is configured on an enemy-by-enemy basis using the notes field for each
enemy.

	From here-on, Mars Battle Engine will be abreviated MaBE.

=== BASICS ===
	Without configuring an enemy, the MaBE sits idle and does nothing.
Furthermore, it should not get in the way of any other script that uses the note
field. When scanning the notes field for rules, MaBE does the following:

	1.	If a line begins with <mars-config> or <mars-end-config>, an internal
			flag is set. Then the interpreter continues to the next line.
	2.	If a line begins <mars>, then the rest of it is read.
  3.	If a line falls between a line with <mars-config> and <mars-end-config>,
			then is treated as if it started with <mars>.

(Note that, for for each of these rules, all checks are case-insensitive. That
is, <mars>, <MARS>, and <Mars> are all considered identical. Choose your
favorite.)

If a given line is marked for reading, all instances of <mars> are ignored. If
it starts with a pound symbol (i.e. '#'), then the line is ignored. (Note that
this ONLY applies if it STARTS with the '#'.) Use the '#' symbols to create
comments within <mars-config> blocks.

Once the scanning step is done, then all the remaining rules are stored. The
format for each line is:

	RuleName [Argument 1] [Argument 2] ... [Argument N]

Valid arguments vary with the rule in question. Not all rules require
(or accept) arguments.

Also, in RPG Maker VX Ace, lines are wrapped. However, it isn't obvious without
using notes. It's a good idea to add comments if it isn't clear.

=== RULES ===
WIP

=== EXAMPLE ===
WIP

=== TODO ===
Preprocessing ~ substitute constants
GOTO ~ allow rules to return line numbers instead

=end