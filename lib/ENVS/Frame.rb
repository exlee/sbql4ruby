module ENVS

  class Frame
    
    def initialize(*args)
      case(args.size)
        when 0
          @VAR_BINDER = nil
        when 1
          if(args.is_a?(Binder))
            @VAR_BINDER = args
          elsif
            raise ENVSTypeError.new("Incorrect object type [#{var_Object.class}], " + Binder.to_s() + " expected")
          end
        else
          raise ArgumentError.new("Incorrect number of arguments [#{args.size}]")
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
        raise ENVNotInitialisedObjectException.new("Not initilised binder object")
      end
      
      for i in (0...@VAR_BINDER.length)
        var_Message += @VAR_BINDER[i].to_s()

        if(i<@VAR_BINDER.length-1)
          var_Message += ", "  
        end
      end  
          
      return var_Message
    end
        
    # VAR_STACK:Array - QRES stack  
    attr_reader :VAR_BINDER
    
  end
  
end