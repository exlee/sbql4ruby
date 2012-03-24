module AST

require "lib/AST/UnaryExpression"
  

  # Class: GroupAsExpression
  # Extends: UnaryExpression
  # 
  # Class implementing GroupAs expression
  class GroupAsExpression < UnaryExpression
 
    def initialize(var_Name, var_Expression)
      super(var_Name, var_Expression)
    end
  end
end
