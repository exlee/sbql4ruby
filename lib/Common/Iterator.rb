module Common
  
  # Simple iterator class
  class Iterator

    # Params:
    #
    # var_Array:Array - Array object
    #
    # Returns:
    #
    # Throws:   
    def initialize(var_Array)
      
      if(!var_Array.is_a?(Array))
        raise IncorrectArgumentError.new("Incorrect object type [#{var_Array.class}], " + Array.to_s() + " expected")
      end
      
      @VAR_ARRAY = var_Array
      @VAR_ARRAY_INDEX = 0; 
    end
    
    # Returns the first object from array.
    #
    # Params:
    #
    # Returns:Object
    #
    # Throws:
    def first()
      if(var_Array == nil)
        return nil
      end
      
      return @VAR_ARRAY[0]
    end

    # Returns the last object from array.
    #
    # Params:
    #
    # Returns:Object
    #
    # Throws:    
    def last()
      if(@VAR_ARRAY == nil)
        return nil
      end
      
      return @VAR_ARRAY[@VAR_ARRAY.size()-1]
    end

    # Returns the next object from array.
    #
    # Params:
    #
    # Returns:Object
    #
    # Throws:    
    def next()
      if(@VAR_ARRAY == nil)
        return nil
      end
          
      if(hasNext())
        @VAR_ARRAY_INDEX += 1

        return @VAR_ARRAY[@VAR_ARRAY_INDEX-1]
      end
     
      return nil
    end
    
    # Returns true when the array index is lower
    # than the number of objects kept by the array.
    # Otherwise it's false.
    #
    # Params:
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def hasNext()
      if(@VAR_ARRAY_INDEX == @VAR_ARRAY.size())
        return false
      else
        return true
      end
    end

    # Returns a string representation of SBAObject.
    #
    # Params:
    #
    # Returns: String
    #
    # Throws:
    def to_s()
       var_text = "Class=[" + self.class.to_s() + "], size=[" + @VAR_ARRAY.size().to_s() + "], value: ["

        @VAR_ARRAY.each{|object| var_text += " " + object.to_s()}

        return var_text + " ]"
    end
        
  end
  
end