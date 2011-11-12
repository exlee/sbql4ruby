module ENVS

require "lib/Common/exceptions"

require "lib/ENVS/Binder"


  class Frame
    
    def initialize(*args)
      
      puts "args counter=" + args.size().to_s()
      
      case(args.size)
        when 0
          @VAR_BINDER = nil
        when 1
          if(args[0].is_a?(NilClass))
            @VAR_BINDER = nil
          elsif(args[0].is_a?(Array))
            @VAR_BINDER = args[0]
          else
            raise ENVSTypeError.new("Incorrect object type [#{args[0].class}], " + Array.to_s() + " expected")
          end
        else
          raise ENVSIncorrectArgumentException.new("Incorrect number of arguments [#{args.size}]")
      end
    end
  
    # Returns a string representation of Frame object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      if(@VAR_BINDER == nil)
        return "nil"
      end
      
      #puts "TEST=" + @VAR_BINDER.length.to_s + ", " + @VAR_BINDER.class.to_s
      
      var_Message = ""
      
      @VAR_BINDER.each {|binder| var_Message += binder.to_s() + "\n"}
          
      return var_Message
    end
        
    # VAR_STACK:Array - QRES stack  
    attr_reader :VAR_BINDER
    
  end
  
end