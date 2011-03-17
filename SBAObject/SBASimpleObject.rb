module SBAStore
  
require "SBAObject"

  # SBA store abstract class for simple objects 
  class SBASimpleObject < SBAStore::SBAObject

    # Constructor
    #
    # Params:
    #
    # var_Name:String - SBA store object name
    #
    # var_Object:Object - SBA store data object
    #
    # Returns: nil
    def initialize(var_Name, var_Object)
      if(!var_Object.is_a? String)
        raise TypeError  "Incorrect object type '(#{var_Object.class})', 'String' expected"
      end
      
      puts "#{var_Object.class}"
      super(var_Name, var_Object)
    end
  
  end
test = SBASimpleObject.new("AAA", 12)
puts "#{test.VAR_OBJECT}"
end