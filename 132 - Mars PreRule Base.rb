#==============================================================================
# ■ Mars::PreRules::Base
#==============================================================================
module Mars
	module PreRules
		class Base
			
			# TODO: Finish this. It will be used as as pre-processor rule stuff. e.g.
			# substituting values in at preprocessing time. This can be used to help
			# clarify rules by turning attack numbers into attack names.
			
			### OVERRIDE THIS FUNCTION WHEN MAKING NEW RULES ###
			
			## ProcessRule
			# This is a virtual function that decides what to do given a set of rules.
			# 
			#		Array<RPG::Enemy::Action> actions
			#	All possible actions to choose from.
			#	
			#		Array<String> words
			#	The first word is always the rule, while subsequent values (if any) are
			#	arguments.
			#
			# 	Returns:
			#	RPG::Enemy::Action	- Implies action to be run
			# int									- Implies line to jump to
			# nil									- This rule didn't trigger anything; try the next one
			# anything else				- Yields undefined behaviour
			def ProcessPreRule(rules)
				return nil
			end
			
		end # class Base
	end # module PreRules
end # module Mars