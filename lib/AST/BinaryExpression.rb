module AST
  
require "lib/AST/Expression"


  # Class: BinaryExpression
  # Extends: Expression
  #
  # Abstract class for terminal expressions
  class BinaryExpression < Expression
    
    @@var_Left = "LEFT"
    @@var_Right = "RIGHT"
    
    # Method: initialize (constructor)
    # Params:
    #
    # var_LeftExpression:Expression - Left expression
    #
    # var_RightExpression:Expression - Right expression
    #
    # Returns:
    #
    # Throws:IncorrectArgumentException    
    def initialize(var_LeftExpression, var_RightExpression)
 
      if(!var_LeftExpression.is_a?(Expression) || !var_RightExpression.is_a?(Expression))
        IncorrectArgumentException.new("Incorrect arguments type [#{var_LeftExpression.class.to_s()}], [#{var_RightExpression.class.to_s()}] " +
          "expected [#{Expression.class.to_s()}]")
      end
       
      var_Value = Hash.new()
       
      var_Value[:var_Left] = var_LeftExpression
      var_Value[:var_Right] = var_RightExpression
       
      super(var_Value)
     end

     # Method: getLeftExpression
     #
     # Returns left expression.
     #
     # Params:
     #
     # Returns:Expression
     #
     # Throws:     
     def getLeftExpression()
       return self.VAR_VALUE[:var_Left]
     end    

     # Method getRightExpression
     #
     # Returns right expression.
     #
     # Params:
     #
     # Returns:Expression
     #
     # Throws:     
     def getRightExpression()  
       return self.VAR_VALUE[:var_Right]
     end
     
     # Method: to_s
     #
     # Returns a string representation of BinaryExpression object.
     #
     # Params:
     #
     # Returns:String
     #
     # Throws:
     def to_s
       if(@VAR_VALUE == nil)
         return super()
       else
         return "[Type=#{self.class.to_s()}, LeftValue=#{self.VAR_VALUE[:var_Left].to_s()}, RightValue=#{self.VAR_VALUE[:var_Right].to_s()}]"
       end
     end
     
     def print(indent=0)
       indenting = 4

       if(@VAR_VALUE == nil)
         return
       else
         puts " "*indent + "["
         puts " "*indent + " Type=#{self.class.to_s()},"
         puts " "*indent + " LeftValue=\n"
         self.VAR_VALUE[:var_Left].print(indent+indenting)
         puts " "*indent + " RightValue=\n"
         self.VAR_VALUE[:var_Right].print(indent+indenting)
         puts " "*indent + "]\n"
       end
     end
  end
end
