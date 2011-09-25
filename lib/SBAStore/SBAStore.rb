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

    # Removes object from the SBA store. This method finds object
    # using given id and deletes reference.
    #
    # Params:
    #
    # var_Identifier:Integer - SBA store object's identifier
    #
    # Returns:
    #
    # Throws:
    def remove(var_Identifier)

    end 
    
    # Returns a string representation of SBAStore
    # and all its attributes.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s
      var_text = "Store=[#{self.class}], objects=[#{@VAR_OBJECTS_COUNTER.to_s()}]\n"
      
      @VAR_OBJECTS.each{|object| var_text+=object.to_s()+"\n"}
      
      return var_text
    end
    
    # VAR_BASE:Array - SBA store objects array
    attr :VAR_OBJECTS
    
    # VAR_OBJECT_COUNTER:Integer - SBA store object counter
    attr :VAR_OBJECTS_COUNTER
    
    
     
  end   
      
end