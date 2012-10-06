module AST
  
require "lib/AST/AbstractMethodException"


  # Class: Expression
  #
  # Abstract class representing expression
  class Expression
 
    # Method: initialize (constructor)
    # 
    # Params:
    #
    # var_Value:Array - expressions
    #
    # Returns:
    #
    # Throws:    
    def initialize(var_Value)
      @VAR_VALUE = var_Value
    end
    
    # Method: execute
    # 
    # Abstract method, should be implemented by the inheriting 
    # classes (valids given object).
    #
    # Params:
    #
    # Returns:
    #
    # Throws: AbstractMethodExcepion
    def execute(var_AST)
      raise AbstractMethodException.new("Abstract method")
    end
    
    # Method: to_s
    # Returns a string representation of Expression object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s
      if(@VAR_VALUE == nil)
        return "[Type=#{self.class.to_s()}, Value=nil]"
      else
        return "[Type=#{self.class.to_s()}, Value=#{@VAR_VALUE.to_s()}]"
      end
    end
    
    def print(indent=0)
      indenting = 4
      
      if(self.is_a?(NameExpression))
        puts " "*indent + "[Type=#{self.class.to_s()}, Name = #{@VAR_NAME}]\n"
      elsif(self.is_a?(AsExpression))
        puts " "*indent + "[Type=#{self.class.to_s()}, Name = #{@VAR_NAME}, Value = \n"
        @VAR_VALUE.print(indent+indenting)
        puts " "*indent+"]\n"
      elsif(@VAR_VALUE == nil)
        puts " "*indent + "[Type=#{self.class.to_s()}, Value = nil]"
      elsif(@VAR_VALUE.is_a?(Expression))
        puts " "*indent + "[Type=#{self.class.to_s()}, Value = \n"
        @VAR_VALUE.print(indent+indenting)
        puts " "*indent+"]\n"
      else
        puts " "*indent + "[Type=#{self.class.to_s()}, Value = #{@VAR_VALUE.to_s}]\n"
      end
    end
    
    # Getter for VAR_VALUE variable
    attr_reader :VAR_VALUE
  end
end
