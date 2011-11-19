module ENVS

require "lib/Common/exceptions"

require "lib/QRES/BagResult"
require "lib/ENVS/Binder"


  class Frame
    
    def initialize(*args)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Initialisation for the number of arguments [#{args.size().to_s()}]")
      
      case(args.size)
        when 0
          
          @VAR_BINDER_LIST = nil
        when 1
          if(args[0].is_a?(NilClass))
            
            Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Setting up NULL value for the frame")
            
            @VAR_BINDER_LIST = nil
          elsif(args[0].is_a?(Array))
            
            Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Setting up binder array list, the numer of given call attributes [#{args[0].size().to_s()}], data [#{args[0].to_s()}]")
            
            @VAR_BINDER_LIST = args[0] 
            
          else
            raise ENVSTypeError.new("Incorrect object type [#{args[0].class}], " + Array.to_s() + " expected")
          end
        else
          raise ENVSIncorrectArgumentException.new("Incorrect number of arguments [#{args.size}]")
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: End, length [#{@VAR_BINDER_LIST.size().to_s()}], data [#{@VAR_BINDER_LIST.to_s()}]")
    end
  
    def findAllByName(var_Name)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[findAllByName]: Looking for the object [#{var_Name}] in the frame")
      
      bag = QRES::BagResult.new()
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[findAllByName]:  [#{bag.to_s()}]")
       
      for i in 0..@VAR_BINDER_LIST.length()-1
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[findAllByName]: Looking for the binder object [#{@VAR_BINDER_LIST[i].to_s()}] in the frame")
        
        if(@VAR_BINDER_LIST[i].VAR_NAME == var_Name)
          Common::Logger.print(Common::VAR_DEBUG, self, "[findAllByName]: Objects are matched by the name [#{var_Name}], pushing into the bag")
          
          bag.push(@VAR_BINDER_LIST[i])
        end
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[findAllByName]: Returning bag[#{bag.to_s()}]")
      
      return bag
    end
     
    # Returns a string representation of Frame object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      var_Message = " ENVS Frame:"
      
      if(@VAR_BINDER_LIST == nil)
        return var_Message += " nil"
      end

      var_Message += "\n"
      
      @VAR_BINDER_LIST.each {|binder| var_Message += "   " + binder.to_s() + "\n"}
          
      return var_Message
    end
        
    # VAR_STACK:Array - QRES stack  
    attr_reader :VAR_BINDER_LIST
    
  end
  
end