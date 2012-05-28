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
      
      # Simple iterator
      arg1Iterator = var_Arg1.iterator()
      arg2Iterator = var_Arg2.iterator()
      
      while(arg1Iterator.hasNext() && arg2Iterator.hasNext())
        arg1Object = Utils::dereference(arg1Iterator.next(), var_AST)
        arg2Object = Utils::dereference(arg2Iterator.next(), var_AST)
        
        puts "[Comparator]: arg1=#{arg1Object.to_s()}, arg2=#{arg2Object.to_s()}"
      end
    end
  end
end