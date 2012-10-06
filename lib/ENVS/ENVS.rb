module ENVS

require "lib/SBAStore/SBAComplexObject"

require "lib/QRES/ReferenceResult"
require "lib/QRES/StructResult"
require "lib/QRES/BagResult"
require "lib/QRES/BinderResult"

require "lib/ENVS/Binder"
require "lib/ENVS/Frame"

require "lib/Operator/DataTypeException"

require 'lib/Common/logger'
require "lib/Common/exceptions"


  # Class: ENVS
  # 
  # Class which implements Environment Stack
  class ENVS
    
    
    # Method: initialize (constructor)
    # 
    # Initializes ENVS stack using SBA Store
    # 
    # Params:
    # var_store - SBAStore object, for which ENVS Stack will be created
    # 
    # Throws:
    # ENVSTypeError - when store is not SBAStore object
    def initialize(var_Store) 
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Initialisation for given store")
      Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Store dump:\n#{var_Store.to_s()}")
          
      @VAR_STACK = Array.new()
      
      if(!var_Store.is_a?(SBAStore::SBAStore))
        raise ENVSTypeError.new("Incorrect object type [#{var_Store.class}], " + SBAStore.to_s() + " expected")
      else
        Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Creating frame for root object [" + 
          var_Store.getRootObject().to_s() + "]")
        
        frame = createFrame(var_Store.getRootObject(), var_Store)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: Created frame:\n" + frame.to_s())
            
        @VAR_STACK.push(frame)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[initialize]: End ")
      end
    end
    
    # Method: createFrame
    #
    # Creates ENVS frame
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns:Frame
    #
    # Throws:DataTypeException
    def createFrame(var_Object, var_Store)
        
      Common::Logger.print(Common::VAR_DEBUG, self, "[createFrame]: Creating frame for [#{var_Object.to_s()}]")
      
      binderList = createBinder(var_Object, var_Store)
       
      Common::Logger.print(Common::VAR_DEBUG, self, "[createFrame]: Created binder list, lenght " +
        "[#{binderList.to_s()}], data [#{binderList.to_s()}]")
      
      frame = Frame.new(binderList)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[createFrame]: Created frame\n[#{frame.to_s()}]")
      
      return Frame.new(binderList)
    end

    # Method: createBinder
    #
    # Creates ENVS binder
    #
    # Params:
    #
    # var_Object:AbstractQueryResult - QRES object
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns:Frame
    #
    # Throws:DataTypeException    
    def createBinder(var_Object, var_Store)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Creating binder for [#{var_Object.to_s()}]")
       
      # Binder list to be returned
      var_BinderList = Array.new()
      
      # Nested for SBAObject used for ENVS initialisation
      if(var_Object.is_a?(SBAStore::SBAComplexObject))
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Creating binder for " +
          "[#{SBAStore::SBAComplexObject.to_s()}], searching in the store")
        
        iterator = var_Object.iterator()

        while(iterator.hasNext())
          
          object = var_Store.find(iterator.next())
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Found object [#{object.to_s()}], creting binder")
          
          binder = Binder.new(object.VAR_NAME, QRES::ReferenceResult.new(object.VAR_ID))
        
          #binder = createBinder(object, var_Store)
                    
          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Created binder [#{binder.to_s()}], " +
            "adding to the array")
          
          var_BinderList.push(binder)
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Current binder array length " +
            "[#{var_BinderList.length().to_s()}]")
        end
        
        return var_BinderList
      elsif(var_Object.is_a?(QRES::ReferenceResult))
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Creating binder for [#{QRES::ReferenceResult.to_s()}], " +
          "searching in the store")
        
        object = var_Store.find(var_Object.VAR_OBJECT)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Found [#{object.to_s()}], creating binder")
        
        binderList = createBinder(object, var_Store)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Created binder array, length " +
          "[#{binderList.length().to_s()}], data [#{binderList.to_s()}]")
 
        return binderList
      elsif(var_Object.is_a?(QRES::BagResult) || var_Object.is_a?(QRES::StructResult))
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Creating binder for " +
          "[#{var_Object.class.to_s()}], searching in the store")
        
        iterator = var_Object.iterator()
        
        while(iterator.hasNext())
          object = var_Store.find(iterator.next().VAR_OBJECT())

          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Found object [#{object.to_s()}], " + 
            "creating binder")
          
          binder = createBinder(object, var_Store)
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Created binder array, length " +
            "[#{binder.length().to_s()}]")

          binder.each{|biner| var_BinderList.push(binder)}
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Current binder array length " +
            "[#{var_BinderList.length().to_s()}]")
          
          return var_BinderList
        end    
      elsif(var_Object.is_a?(QRES::BinderResult))
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Creating binder for " +
          "[#{QRES::BinderResult.to_s()}], creating binder")
        
        binderList = [Binder.new(var_Object.VAR_NAME, var_Object.VAR_OBJECT)]
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Created binder, length " +
          "[#{binderList.length().to_s()}]")
        
        binderList.each{|binder| var_BinderList.push(binder)}
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[createBinder]: Current binder array after join, length " +
          "[#{var_BinderList.length().to_s()}]")
        
        return var_BinderList
      end
      
      return var_BinderList
    end

    # Method: bind
    #
    # Binds given object name
    #
    # Params:
    #
    # var_Name:Strig - Object name
    #
    # Returns:BagResult
    #
    # Throws:
    def bind(var_Name)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[bind]: Binding for object name [#{var_Name}]")
       
      bag = QRES::BagResult.new()
        
      i = @VAR_STACK.length-1
    
      Common::Logger.print(Common::VAR_DEBUG, self, "[bind]: The number of frames in the stack [#{@VAR_STACK.length.to_s()}]")
       
      while(i>=0)
        
        Common::Logger.print(Common::VAR_DEBUG, self, "[bind]: Searching for object name [#{var_Name}], frame [#{i.to_s()}]")
        
        
        bag = @VAR_STACK[i].findAllByName(var_Name)
        if(bag.VAR_OBJECT().size() > 0)
          Common::Logger.print(Common::VAR_DEBUG, self, "[bind]: Found [#{bag.to_s()}], breaking")
          
          break
        end
              
        i -= 1
      end
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[bind]: Returning [#{bag.to_s()}]")
      
      return bag
    end

    # Method: nested
    #
    # Nested operation on ENVS stack
    #
    # Params:
    #
    # var_SBAObject:SBAObject - SBA object
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns:
    #
    # Throws:DataTypeException    
    def nested(var_SBAObject, var_Store)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[nested]: Nested for object [#{var_SBAObject.to_s()}]")
      
      frame = createFrame(var_SBAObject, var_Store)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[nested]: Pushing frame into the stack\n[#{frame.to_s()}]")
      
      @VAR_STACK.push(frame)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[nested]: End")
    end
    
    # Method: pop
    #
    # Gets object from the stack 
    #
    # Params:
    #
    # Returns:AbstractQueryResult
    #
    # Throws: 
    def pop()
      return @VAR_STACK.pop()
    end
    
    # Method: to_s
    #
    # Returns a string representation of Frame object.
    #
    # Params:
    #
    # Returns:String
    #
    # Throws:
    def to_s()
      var_Message = "ENVS Stack:"
      if(@VAR_STACK == nil)
        return var_Message += " nil"
      end

      var_Message += "\n"
      
      @VAR_STACK.each {|frame| var_Message += frame.to_s() + "\n"}
          
      return var_Message
    end
    
    alias push createFrame
    
    # VAR_STACK:Frame - object name  
    attr_reader :VAR_STACK
  end
  
end
