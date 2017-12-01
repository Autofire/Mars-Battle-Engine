#		goto <location>
#		goto <expression>
#
# If goto is followed by a literatal number, then its value is returned. Note
# that this does not include negative numbers.
#
# If goto is followed by anything other than a literal number, then it is
# assumed to be some MaBE expression, and it is parsed as such. If this
# expression returns anything other than an integer, then nil is returned
# instead.

module Mars::Rules
	
	class Goto < Base
		def ProcessRule(actions, words)
			
			result = nil;
			
			# Thanks to Rado et. al. for this if block
			# https://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
		  if( !/\A\d+\z/.match(words[1]) )
				#Is not a positive number
				result = Mars::Core::ProcessRule(actions, words[1, words.size - 1])
				
				unless(result.is_a? Integer)
					result = nil
					
					Mars::Debug::Log(
						Mars::Debug::LOG_WARN,
						"Mars::Goto - condition returned non-integer value; assuming nil"
					)
					
				end
				
			else
				result = words[1].to_i
				
			end # if( !/\A\d+\z/.match(words[1]) )
			
			#if(words[1].to_int()
			return result;
			
		end # def ProcessRule
	end # class Goto
	
end # module Mars::Rules

Mars::Core::RegisterRule(Mars::Rules::Goto.new, "goto")

	
	