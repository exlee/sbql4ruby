module SBAStore
  
require "SBASimpleObject"

  # SBA store Integer class 
  class SBAString < SBASimpleObject
    
    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:String - SBA store object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      if(!var_Object.is_a? String)
        raise TypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end

  end

end