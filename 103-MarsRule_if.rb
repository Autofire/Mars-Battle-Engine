#		if <condition> then <action>
# Parses whatever rule is in <condition>. If this returns anything other than
# nil, then <action> is executed and its return value is used. If <condition>
# return nil, then nil is returned.

module Mars::Rules
	
	class If < Base
		def ProcessRule(actions, words)
			thenIndex = words.index("then")
			raise(ArgumentError, "Mars::if - must have a 'then' following all ifs") if thenIndex.nil?
			
			condition = words[1, thenIndex - 1]
			trueAction = words[thenIndex + 1, words.size - thenIndex - 1]
			#falseAction = ...
			
			cResult = Mars::Core::ProcessRule(actions, condition)
			
			unless(cResult.nil?)
				return Mars::Core::ProcessRule(actions, trueAction)
			end
			
			return nil
		end # def ProcessRule
	end # class If
	
end # module Mars::Rules

Mars::Core::RegisterRule(Mars::Rules::If.new, "if")