module SBAStore

require "lib/Common/exceptions"

  
  class SBAStore
    
    # Initialises array for SBA store.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:
    def initialize()  
      @VAR_OBJECTS = Array.new()
      @VAR_OBJECTS_COUNTER = 0
    end
    
    # Adds a new object to the SBA store.
    #
    # Params:
    #
    # var_Object:SBAObject - SBA object
    #
    # Returns:
    #
    # Throws:SBATypeError
    def add(var_Object)
      if(!var_Object.is_a? SBAObject)
        raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
      end
       
      @VAR_OBJECTS.push(var_Object)
      @VAR_OBJECTS_COUNTER+=1
    end
    
    # Returns an object indicated by the array index.
    #
    # Params:
    #
    # var_Index:Fixnum - Object index
    #
    # Returns:
    #
    # Throws:SBATypeError
    def get(var_Index)
      if(var_Index > @VAR_OBJECTS.size || var_Index < 0)
        raise SBAIndexError.new("Incorrect object index [#{var_Index}], current index range [0...#{@VAR_OBJECTS.size}]")
      end
       
     return @VAR_OBJECTS[var_Index]
    end
    
    # Returns the bottom object from the stack 
    #
    # Params:
    #
    # Returns:SBAObjects
    #
    # Throws:     
    def getRootObject()
      if(@VAR_OBJECTS == nil || @VAR_OBJECTS.size() == 0)
        return nil
      end

      return self.find(0)
    end
      
    # Finds an object indicated by the SBA identifier.
    #
    # Params:
    #
    # var_Identifier:Fixnum - SBA object identifier
    #
    # Returns:
    #
    # Throws:SBAIdentifierError
    def find(var_Identifier)
      if(var_Identifier > SBAObject.VAR_OBJECT_COUNTER || var_Identifier < 0)
        raise SBAIdentifierError.new("Incorrect SBA object identifier [#{var_Identifier}], current idex range [0 .. #{SBAObject.VAR_OBJECT_COUNTER}]")
      end
      
      @VAR_OBJECTS.each do |object|
        if(object.VAR_ID == var_Identifier)
          return object
        end
      end
  
      return nil
    end

    # Returns a string representation of SBAStore
    # and all its attributes.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      var_text = "Store=[#{self.class}], objects=[#{@VAR_OBJECTS_COUNTER.to_s()}]\n"
      
      @VAR_OBJECTS.each{|object| var_text+=object.to_s()+"\n"}
      
      return var_text
    end
    
    # Alias for add method.
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # Returns:
    #
    # Throws:
    alias push add
    
    # VAR_BASE:Array - SBA store objects array
    attr :VAR_OBJECTS
    
    # VAR_OBJECT_COUNTER:Integer - SBA store object counter
    attr :VAR_OBJECTS_COUNTER
      
  end   
      
end