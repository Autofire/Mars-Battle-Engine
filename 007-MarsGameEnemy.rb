#==============================================================================
# ■ Game_Enemy
#==============================================================================
class Game_Enemy < Game_Battler
	
	# Class variables:
	
	#		Array<String> @rules
	# This is the list of rules. It's a 2D array, with the first index being
	# a given rule and the second being the rule and its options.
	# Be wary that this may be nil. If it is, then the enemy lacks any options.
	
	alias mars_initialize initialize
	def initialize(index, enemy_id)
		# Unfortunately, Game_Enemy's initialize
		# requires some arguments, so this isn't nice and clean
		mars_initialize(index, enemy_id)
		
		@rules = Mars::Core::interpret_notes(note)
		
		Mars::Debug::Log(Mars::Debug::LOG_FULL, "All rules: " + @rules.to_s)
	end
	
	alias mars_select_enemy_action select_enemy_action
	def select_enemy_action(action_list, rating_zero)
		Mars::Debug::Log(Mars::Debug::LOG_FULL, "All available actions: " + action_list.to_s)
		action = Mars::Core::ChooseAction(action_list, @rules)
		
		if(action.nil?)
			Mars::Debug::Log(1, "Mars failed to yield an action; falling back to RPGVXA")
			action = mars_select_enemy_action(action_list, rating_zero)	
		end
		
		Mars::Debug::Log(2, battler_name + " chooses " + action.to_s)
		
		return action
	end
end # End of class