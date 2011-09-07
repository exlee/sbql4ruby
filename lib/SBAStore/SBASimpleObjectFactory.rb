module SBAStore
  
require "SBAInteger"
require "SBAFloat"
require "SBABoolean"
require "SBAString"


  class SBASimpleObjectFactory
    
    # Method:SBASimpleObjectFactory.create
    #
    # Verifies given simple object type and
    # creates a new SBA object depending
    # on the verify result.
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    # var_Object:String - SBA store object
    #
    # Returns:SBAObject
    #
    # Throws:SBATypeError
    def SBASimpleObjectFactory.create(var_Name, var_Object) 
      if(SBAInteger.isValidType?(var_Object))
        puts "SBASimpleFacotry: Integer"
        return SBAInteger.new(var_Name, var_Object)
      elsif(SBAFloat.isValidType?(var_Object))
         puts "SBASimpleFacotry: Float"
        return SBAFloat.new(var_Name, var_Object)
      elsif(SBABoolean.isValidType?(var_Object))
         puts "SBASimpleFacotry: Boolean"
        return SBABoolean.new(var_Name, var_Object)
      elsif(SBAString.isValidType?(var_Object))
         puts "SBASimpleFacotry: String"
        return SBAString.new(var_Name, var_Object)
      end
      
      raise SBATypeError.new("Incorrect object type [#{var_Object.class}]")
    end
    
    # Method:SBASimpleObjectFactory.isValidType?
    #
    # Verifies given object type and returns 
    # true if it's an instance of object
    # that is suppotrted by the SBAObject.
    #
    # Params:
    #
    # var_Object:Object - Object to be verified
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBASimpleObjectFactory.isValidType?(var_Object) 
      if( SBAInteger.isValidType?(var_Object)  ||
          SBAFloat.isValidType?(var_Object)    ||
          SBABoolean.isValidType?(var_Object)  ||
          SBAString.isValidType?(var_Object) )
        return true
      end
      
      return false
    end
    
    # Method:SBASimpleObjectFactory.isValidSBAType?
    #
    # Verifies given object type and returns 
    # true if it's an instance of SBAObject.
    #
    # Params:
    #
    # var_Object:SBAOBject - SBA object to be verified
    #
    # Returns:TrueClass/FalseClass
    #
    # Throws:
    def SBASimpleObjectFactory.isValidSBAType?(var_Object) 
      if( var_Object.is_a?(SBAInteger) ||
          var_Object.is_a?(SBAFloat)   ||
          var_Object.is_a?(SBABoolean) ||
          var_Object.is_a?(SBAString) )
        return true
      end
      
      return false
    end
      
  end
  
end