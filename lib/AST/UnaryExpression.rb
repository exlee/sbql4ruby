module AST
  
require "lib/AST/Expression"


  # Abstract class for terminal expressions
  class UnaryExpression < Expression
      
    # Params:
    #
    # var_Expression:Expression - Expression
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def initialize(var_Expression=nil)
 
      if(!var_Expression.is_a?(Expression) && var_Expression != nil)
        IncorrectArgumentException.new("Incorrect arguments type [#{var_Expression.class.to_s()}] expected [#{Expression.class.to_s()}]")
      end
       
      super(var_Expression)
     end
     
     # Returns a string representation of UnaryExpression object.
     #
     # Params:
     #
     # Returns:String
     #
     # Throws:
     def to_s
       if(@VAR_VALUE == nil)
         return "[Type=#{self.class.to_s()}]"
       else
         return "[Type=#{self.class.to_s()}, Value=#{self.VAR_VALUE.to_s()}]"
       end
     end
  end
end