module ENVS

require "lib/SBAStore/SBAComplexObject"
require "lib/QRES/ReferenceResult"

require "lib/Common/exceptions"


  class ENVS
    
    def initialize(var_Store)
      @VAR_STACK = Array.new()
      
      if(!var_Store.is_a?(SBAStore::SBAStore))
        raise ENVSTypeError.new("Incorrect object type [#{var_Store.class}], " + SBAStore.to_s() + " expected")
      else
        frame = createFrame(var_Store.getRootObject(), var_Store)
        
         if(frame.is_a?(NilClass))
            puts "Object=nil"
          else
            puts "Object=" + frame.class.to_s()
            puts "Iniside=\n" + frame.to_s()
          end
          
        @VAR_STACK.push(frame)
      end
    end
    
    def createFrame(var_SBAObject, var_Store)
      return Frame.new(createBinder(var_SBAObject, var_Store))
    end
    
    def createBinder(var_SBAObject, var_Store)
      
      # Binder list to be returned
      var_BinderList = Array.new()
      
      if(var_SBAObject.is_a?(SBAStore::SBAComplexObject))
        iterator = var_SBAObject.iterator()
        
        while(iterator.hasNext())
          object = var_Store.find(iterator.next())
          
          var_BinderList.push(Binder.new(object.VAR_NAME, QRES::ReferenceResult.new(object.VAR_ID)))
        end
        
        return var_BinderList
      end

    end

    def bind()
      
    end
    
    def nested()
      
    end
    
    # VAR_STACK:Frame - object name  
    attr_reader :VAR_STACK
  end
  
end