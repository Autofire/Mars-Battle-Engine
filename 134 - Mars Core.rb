# Edit this at your own risk.

#==============================================================================
# ■ Mars::Core
#==============================================================================
module Mars
	module Core
		# This should hold an instance of every inheritor of Mars_Rule_Base
		@@allRules = {}			# Note to self: This is a map
		
		# This holds an instance of every inheritor of Mars_PreRule_Base
		@@allPreRules = []	# Note to self: This is a array
		
		## Core.RegisterRule
		# Adds an instance of a rule object to the list of rules.
		#
		#		Mars_Rule_Base newRule
		# The new rule object, which must inherit from Mars_Rule_Base
		#
		#		String ruleName
		# Name of the rule which the object parses.
		#
		#		Returns:
		#	Nothing
		def self.RegisterRule(newRule, ruleName)
			raise(
				ArgumentError,
				"Cannot register rule unless rule inherits from Mars::Rules::Base"
			) unless newRule.is_a?(Rules::Base)
			
			@@allRules[ruleName] = newRule
			
			#p(@@allRules)
		end
		
		def self.RegisterPreRule(newRule)
			raise(
				ArgumentError,
				"Cannot register rule unless rule inherits from Mars::PreRules::Base"
			) unless newRule.is_a?(PreRules::Base)
			
			@@allRules += newRule
		end
		
		## Core.FindRule
		# Returns a rule which can answer to ruleName, if any.
		#
		#		string ruleName
		# Name of rule.
		#
		#		Returns:
		# Mars_Rule_Base	- Appropriate rule object to handle the rule
		# nil							- If no matching rule object could be found
		def self.FindRule(ruleName)
			return @@allRules[ruleName]
		end
		
		## Core.ChooseAction
		# Attempts to select an action based on the given rules
		#
		#		Array<RPG::Enemy::Action> actions
		#	All possible actions to choose from.
		#	
		#		Array< <Array<String> > rules
		#	These are ALL of the rules for the current enemy that we are considering.
		#
		#		Returns:
		# RPG::Enemy::Action	- The action which was determined
		# nil									- No action could be determined
		def self.ChooseAction(actions, rules)
			
			if(MAX_JUMPS == -1)
				Mars::Debug::Log(Mars::Debug::LOG_WARN, "Infinte jump checking is turned OFF!")
			end
			
			action = nil
			
			i = 0					# Index into rules array
			jumpCount = 0	# Number of jumps made so far
			
			#rules.each do |rule|
			while(action.nil? && i < rules.length)
				
				result = ProcessRule(actions, rules[i])
				
				if(result.is_a?(Integer))
					i = result
					jumpCount += 1
					
					if(MAX_JUMPS != -1 && jumpCount >= MAX_JUMPS)
						raise(RuntimeError, "MaBE detected an infinite loop. ABORTING!")
					end
					
				elsif(result.nil?)
					i += 1
					
				elsif(result.is_a?(RPG::Enemy::Action))
					action = result
				
				end
				
			end # while i < rules.length
			
			Mars::Debug::Log(Mars::Debug::LOG_NORM, "Jumps made: " + jumpCount.to_s)
			
			return action
		end
		
		## Core.ProcessRule
		# Given a single rule, attempts to parse the action.
		#
		#		Array<RPG::Enemy::Action> actions
		#	All possible actions to choose from.
		#	
		#		Array<String> rule
		#	This is the current rule for the enemy that we are considering.
		#
		#		Returns:
		# See Mars.Rules.Base
		def self.ProcessRule(actions, rule)
			result = nil
			
			ruleHandler = FindRule(rule[0])
			
			# TODO Handle integers
			unless(ruleHandler.nil?)
				result = ruleHandler.ProcessRule(actions, rule)
			end
			
			return result
		end
		
		## Core.interpret_notes
		# This interprets the notes of an enemy. It will load all of the Mars engine
		# rules for that enemy as separate arrays of strings.
		#
		# It will read lines under two conditions:
		#  1: The line starts with <mars>
		#  2: The line falls between lines with <mars-config> and <mars-end-config>
		#
		# However, in either case, empty lines are ignored. Also, all lines starting
		# with '#' are ignored. (NOTE THAT THIS DOES NOT APPLY TO '#' SYMBOLS AFTER
		# THE START OF THE LINE!)
		#
		#
		#		String notes
		# This is the enemy's "note" object. Just pass this directly in.
		#
		#	Returns:
		#		Array<Array<String>>
		# This table is the rules. It's formatted as one rule per outer index, and
		# then that rule's words per inner index.
		def self.interpret_notes(notes)
			found_mars_config_start = false
			rules = []
			
			notes.each_line do |line|
				# Only process lines if we've found a mars config tag
				if(found_mars_config_start || line.downcase[/^<mars>/]) then
					if(line.downcase[/^<mars-end-config>/]) then
						found_mars_config_start = false
					else
						# Split the line into words
						words = line.scan(/[a-zA-Z0-9<>#]*/)
						words.reject! { |word| word == "" }
						words.reject! { |word| word.downcase[/<mars>/] }
						
						# Ignore comments and blank lines
						if(words[0] != "#" and words.size > 0) then
							# Add the line to our list of rules
							rules[rules.size] = words
						end
					end # if(line.downcase[/^<mars-end-config>/])
				elsif(line.downcase[/^<mars-config>/]) then
					found_mars_config_start = true
				end
			end # if(found_mars_config_start || line.downcase[/^<mars>/])
			
			return rules
		end
		
	end #module Core
end # module Mars

