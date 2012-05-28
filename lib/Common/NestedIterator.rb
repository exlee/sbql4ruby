module Common
  
require "lib/Common/Iterator"
  
  
  # Simple iterator class
  class NestedIterator < Iterator

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
      @VAR_ARRAY_INDEX = 0
      
      @VAR_NESTED_ITERATOR = nil
      
      #first()
    end
    
    # Set array index for the first object.
    #
    # Params:
    #
    # Returns:Object
    #
    # Throws:
    def first()
      @VAR_ARRAY_INDEX = 0
    end

    # Set array index for the last object.
    #
    # Params:
    #
    # Returns:Object
    #
    # Throws:    
    def last() 
       @VAR_ARRAY_INDEX = @VAR_ARRAY.size()-1
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
      
      # Checks nested complex object first
      if(@VAR_NESTED_ITERATOR != nil)
        if(@VAR_NESTED_ITERATOR.hasNext())
          return @VAR_NESTED_ITERATOR.next()
        end
        
        @VAR_NESTED_ITERATOR = nil
      end
      
      # Current nested object doesn't exist, takes next object from the local array            
      if(hasNext())
        @VAR_ARRAY_INDEX += 1
        
        # Checks next object's type from the local array
        if(QRES::Utils::isBagResult?(@VAR_ARRAY[@VAR_ARRAY_INDEX-1]) || QRES::Utils::isStructResult?(@VAR_ARRAY[@VAR_ARRAY_INDEX-1]))
          
          # Complex object found, calling nested method on it
          @VAR_NESTED_ITERATOR = @VAR_ARRAY[@VAR_ARRAY_INDEX-1].nestedIterator()
            
          return @VAR_NESTED_ITERATOR.next()
        end
          
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
        if(@VAR_NESTED_ITERATOR != nil)
          return @VAR_NESTED_ITERATOR.hasNext()
        end
          
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
       var_text = "Class=[" + self.class.to_s() + "], size=[" + @VAR_ARRAY.size().to_s() + "], current possition=[#{@VAR_ARRAY_INDEX.to_s()}], value: ["

        @VAR_ARRAY.each{|object| var_text += " " + object.to_s()}

        return var_text + " ]"
    end

    attr_reader :VAR_NESTED_ITERATOR
        
  end
end