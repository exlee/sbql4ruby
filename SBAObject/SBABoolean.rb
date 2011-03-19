module SBAStore
  
require "SBASimpleObject"

  # SBA store Integer class 
  class SBABoolean < SBASimpleObject
    
    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:TrueClass || FalseClass - SBA store object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      if(!(var_Object.is_a? TrueClass) && !(var_Object.is_a? FalseClass))
        raise TypeError.new("Incorrect object type [#{var_Object.class}]")
      end
      
      super(var_Name, var_Object)
    end

  end

end