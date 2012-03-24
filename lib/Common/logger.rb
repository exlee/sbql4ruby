module Common
  
  # VAR_DEBUG:Integer - debug log level
  VAR_DEBUG = 2

  # VAR_WARNING:Integer - debug log level 
  VAR_WARNING = 1

  # VAR_INFO:Integer - debug log level
  VAR_INFO = 0
  
  
  # Class: Logger
  # 
  # Logging class, with main functionality being able to print
  # pretty formatted logs to the console (debugging purpose)
  class Logger
    
    # @@VAR_CURRENT_LEVEL:Integer - Current log level
    @@VAR_CURRENT_LEVEL = 0
    
    
    # Static Method: print
    #
    # Puts message to stdout with debug data format
    #
    # Params:
    #
    # var_Level:Fixnum - log level
    #
    # var_Object:Object - object executing this method
    #
    # var_Message:String - text message to be send to stdout
    #
    # Returns:
    #
    # Throws:
    def Logger.print(var_Level, var_Object, var_Message)     
      if(!validLogLevel(var_Level))
        raise LogLevelError.new("Incorrect log level [" + var_Level + "]")
      end
        
      if(@@VAR_CURRENT_LEVEL >= var_Level)
        puts(var_Object.class.to_s() + "->" + var_Message)
      end
    end
    
    # Static Method: setLogLevel
    #
    # Sets log level
    #
    # Params:
    #
    # var_Level:Fixnum - log level
    #
    # Returns:
    #
    # Throws: LogLevelError
    def Logger.setLogLevel(var_Level)
      if(!validLogLevel(var_Level))
        raise LogLevelError.new("Incorrect log level [" + var_Level + "]")
      end
      
      @@VAR_CURRENT_LEVEL = var_Level
    end
    
    # Static Method: validLogLevel
    #
    # Checks log level
    #
    # Params:
    #
    # var_Level:Fixnum - log level
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def Logger.validLogLevel(var_Level)
      if(var_Level != VAR_DEBUG && var_Level != VAR_WARNING && var_Level != VAR_INFO)
        return false
      end
      
      return true
    end

  end
  
end
