module Mars
	module Core
		
		## int MAX_JUMPS
		# This is the maximum jumps MaBE can make within the span of parsing one set
		# of rules. If a ruleset ever exceeds this number, the game will CRASH!
		# 
		# This is done to ensure that infinite loops are cut short; it is very bad
		# if the game loops infinitely, causing it to hang infinitely. In such a
		# case, it is actually better user experience just to cut fess up and let
		# the player know that something went wrong.
		#
		# If MAX_JUMPS is ever exceeded for a ligitimate reason, you may increase
		# this number. However, if you ever find yourself doing this, it may be best
		# to rethink your ruleset. As a parser, MaBE is inherintly less efficient
		# than RGSS, so using it for a large number of loops is going to be much
		# less efficient (and much less clean) than creating a new rule and using\
		# that.
		#
		# If this is -1 one, then no checking is made. This is really only for
		# testing purposes. If this is disabled, it will be mentioned in the
		# warning log.
		MAX_JUMPS = 10
		
		
	end #module Core
end # module Mars