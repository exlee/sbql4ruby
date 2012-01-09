module AST
  
require "lib/AST/Expression"


  # Abstract class for terminal expressions
  class UnaryExpression < Expression
      
    # Params:
    #
    # var_Name:String - Name
    #
    # var_Expression:Expression - Expression
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def initialize(var_Name, var_Expression=nil)
 
      if(!var_Name.is_a?(String) || (!var_Expression.is_a?(Expression) && var_Expression != nil))
        IncorrectArgumentException.new("Incorrect arguments type [#{var_Name.class.to_s()}], [#{var_Expression.class.to_s()}] " +
          "expected [[#{String.class.to_s()}]], [#{Expression.class.to_s()}]")
      end
       
      @VAR_NAME = var_Name 
       
      super(var_Expression)
     end
     
     # Returns a string representation of BinaryExpression object.
     #
     # Params:
     #
     # Returns:String
     #
     # Throws:
     def to_s
       if(@VAR_NAME == nil)
         return super()
       elsif(@VAR_VALUE == nil)
         return "[Type=#{self.class.to_s()}, Name=#{@VAR_NAME}]"
       else
         return "[Type=#{self.class.to_s()}, Name=#{@VAR_NAME}, Value=#{self.VAR_VALUE.to_s()}]"
       end
     end
     
     attr_reader :VAR_NAME
  end
end