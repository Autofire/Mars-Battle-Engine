#		do <action index>
# Uses action at the given enemy index. Returns nil if index is invalid.

module Mars::Rules
	
	# Uppercased because of reserved word
	class Do < Base
		def ProcessRule(actions, words)
			targetAction = actions[words[1].to_i]
			
			Mars::Debug::Log(Mars::Debug::LOG_WARN, "Mars::Do - action index out of bounds: " + words[1]) if targetAction.nil?
			
			return targetAction
		end
	end # class Do
	
end # module Mars

Mars::Core::RegisterRule(Mars::Rules::Do.new, "do")