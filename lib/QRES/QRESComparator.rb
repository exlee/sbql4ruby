module QRES
  
  require "lib/QRES/Utils"
  
  
  class QRESComparator
    
    # Compares values of two QRES objects 
    #
    # Params:
    #
    # v_Store:SBAStore - Store
    #
    # v_Arg1:AbstractComplexQueryResult - QRES object
    #
    # v_Arg2:AbstractComplexQueryResult - QRES object
    #
    # Returns: TrueClass/FalseClass
    #
    # Throws:
    def QRESComparator::compare(var_Arg1, var_Arg2, var_AST)
      
      if(var_Arg1.is_a?(AbstractSetQueryResult) && var_Arg2.is_a?(AbstractSetQueryResult))
        
        if(var_Arg1.VAR_OBJECT().size() != var_Arg2.VAR_OBJECT().size())
          return 0
        end
        
        # Simple iterator
        arg1Iterator = var_Arg1.iterator()
        arg2Iterator = var_Arg2.iterator()
      
        while(arg1Iterator.hasNext() && arg2Iterator.hasNext())
          arg1Object = Utils::dereference(arg1Iterator.next(), var_AST)
          arg2Object = Utils::dereference(arg2Iterator.next(), var_AST)
        
          puts "[Comparator]: arg1=#{arg1Object.to_s()}, arg2=#{arg2Object.to_s()}"
          
          if(self.compare(arg1Object, arg2Object, var_AST) != 0)
            return self.compare(arg1Object, arg2Object, var_AST)
          end
        end
      else
        if(var_Arg1 > var_Arg2)
          return 1
        elsif(var_Arg1 < var_Arg2)
          return -1
        end
        
        return 0
      end
      
      return 0
    end
  end
end