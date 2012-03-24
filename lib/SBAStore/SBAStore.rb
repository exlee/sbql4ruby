module SBAStore

require "lib/Common/exceptions"

  
  # class: SBAStore
  # 
  # Implements Stack Based Architecture object store
  class SBAStore
    
    # Method: initialize (constructor)
    #
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
    
    # Method: add
    # 
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
    
    # Method: get
    #
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
    # var_Prefix:String - SBA identifier prefix if it's different than default
    #
    # Params:
    #
    # Returns:SBAObjects
    #
    # Throws:     
    def getRootObject(var_Prefix=nil)
      if(@VAR_OBJECTS == nil || @VAR_OBJECTS.size() == 0)
        return nil
      end

      #if(var_Prefix == nil)
      #  return self.find(SBAObject.VAR_IDENTIFIER_PREFIX + "0")
      #end
      
      #return self.find(var_Prefix + "0")
      
      return @VAR_OBJECTS[0]
    end
      
    # Method: find
    #
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
      if(var_Identifier==nil)
        raise IncorrectArgumentException.new("Incorrect SBA object identifier [#{var_Identifier}]")
      end
      
      @VAR_OBJECTS.each do |object|
        if(object.VAR_ID == var_Identifier)
          return object
        end
      end
  
      return nil
    end

    # Method: sortByObjectIdentifier
    #
    # Sorts store by object's identifier.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:
    def sortByObjectIdentifier(var_Prefix=nil)
      
      # SBA auto-created identifiers
      if(var_Prefix==nil)
        @VAR_OBJECTS.sort!{|object1, object2| 
          Integer(object1.VAR_ID[SBAObject.VAR_IDENTIFIER_PREFIX().length()..object1.VAR_ID.length()-1]) <=> 
          Integer(object2.VAR_ID[SBAObject.VAR_IDENTIFIER_PREFIX().length()..object1.VAR_ID.length()-1]) }
      else
        # Exteral identifier prefix
        @VAR_OBJECTS.sort!{|object1, object2| 
          Integer(object1.VAR_ID[var_Prefix.length()..object1.VAR_ID.length()-1]) <=> 
          Integer(object2.VAR_ID[var_Prefix.length()..object1.VAR_ID.length()-1]) }         
      end
    end
    
    # Method: to_s
    #
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
