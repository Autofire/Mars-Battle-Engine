module Mars
	module Debug
		
		# Log modes
		LOG_NONE = 0		# Squelch all debugging (with exception of bad MaBE config)
		LOG_WARN = 1		# Only print warnings related to unexpected behaviour
		LOG_NORM = 2		# Short messages about what is going on
		LOG_FULL = 3		# Dump EVERYTHING, even full arrays, to console.
		
		## DEBUG_LEVEL
		# Modify this to change the amount of debugging you want.
		DEBUG_LEVEL = LOG_NORM
		
		## Debug_Log
		# Prints a message to the console, assuming the debug level is high enough.
		#
		#		int level
		# Level of debugging that the statement is. See the "log modes" constants
		# above for the various levels.
		#
		#		String message
		# Message to print.
		#
		#		Returns:
		# Nothing
		def self.Log(level, message)
			p(message) if level <= DEBUG_LEVEL
		end
		
	end # module Debug
end # module Mars