module XMLDB

require 'lib/Common/exceptions'
require 'lib/Common/logger'

require 'rexml/document'
require 'rexml/streamlistener'
 
require "lib/Common/exceptions"
require "lib/SBAStore/SBAComplexObject"
require "lib/SBAStore/SBASimpleObjectFactory"

include REXML


  class Listener 
    include REXML::StreamListener
    
    # Params:
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Store)
      
      # Store
      @VAR_STORE = var_Store
           
      # The array of complex objects which are not
      # currently added to the store (until their
      # tags are not closed).
      @VAR_COMPLEX_OBJECTS          = Array.new()
      @VAR_COMPLEX_OBJECTS_NAMES    = Array.new()
      @VAR_COMPLEX_OBJECTS_INDEXES  = Array.new()
      
      @VAR_COMPLEX_OBJECT_INDEX     = 0
      
      @VAR_CURRENT_OBJECT           = nil
      @VAR_CURRENT_OBJECTS_NAME     = nil
    end
    
    # Opening tag listener. 
    #
    # Params:
    #
    # var_Args:Array - SBA store object name
    #
    # Returns:
    #
    # Throws:
    def tag_start(*var_Args)
       
      # Getting a current tag name
      var_TagName = var_Args[0] 
      
      Common::Logger.print(Common::VAR_DEBUG, self,
        "[TAG_START]: New tag, name = ["      + var_TagName + 
        "], existing current object name = [" + @VAR_CURRENT_OBJECT_NAME.to_s()   +
        "], current complex index="           + @VAR_COMPLEX_OBJECT_INDEX.to_s())
              
        # Previous object is not registered and it hasn't object value. 
        # That means, previous object is a complex object and it needs
        # to be added to te complex objects list before a new object 
        # will be analysed.
        if(@VAR_CURRENT_OBJECT_NAME != nil && @VAR_CURRENT_OBJECT == nil)
          
          Common::Logger.print(Common::VAR_DEBUG, self, 
            "[TAG_START]: Previous object is a not added complex object = [" + @VAR_CURRENT_OBJECT_NAME + "]")
          
          @VAR_CURRENT_OBJECT = SBAStore::SBAComplexObject.new(@VAR_CURRENT_OBJECT_NAME)
          
          storeObject(@VAR_CURRENT_OBJECT)
          
          Common::Logger.print(Common::VAR_DEBUG, self, "[TAG_START]: Next object = [" + var_TagName + "]")
          
          @VAR_CURRENT_OBJECT_NAME = var_TagName
          @VAR_CURRENT_OBJECT = nil
          
        elsif(@VAR_CURRENT_OBJECT_NAME != nil && @VAR_CURRENT_OBJECT != nil)
          raise InternalError.new("Previous object " + @VAR_CURRENT_OBJECT.to_s() + " is not added to the store")
        else
          Common::Logger.print(Common::VAR_DEBUG, self, "[TAG_START]: Next object = [" + var_TagName + "]")
          
          @VAR_CURRENT_OBJECT_NAME = var_TagName
          @VAR_CURRENT_OBJECT = nil
        end
    end
  
    # Tag data listener. 
    #
    # Params:
    #
    # var_Data:Object - tag data
    #
    # Returns:
    #
    # Throws:
    def text(var_Data)
     return if var_Data =~ /^\W*$/

     Common::Logger.print(Common::VAR_DEBUG, self, 
      "[TAG_DATA]: given data objet [#{var_Data}] for current object name=["  + @VAR_CURRENT_OBJECT_NAME.to_s() +
      "], CMPX INDEX="                                                        + @VAR_COMPLEX_OBJECT_INDEX.to_s())
          
     @VAR_CURRENT_OBJECT = SBAStore::SBASimpleObjectFactory.create(@VAR_CURRENT_OBJECT_NAME, var_Data);
     
     Common::Logger.print(Common::VAR_DEBUG, self, "[TAG_DATA]: current object=[" + @VAR_CURRENT_OBJECT.to_s() + "], type=[" + @VAR_CURRENT_OBJECT.class.to_s() + "]")
   end

   # Closing tag listener. 
   #
   # Params:
   #
   # var_Data:Object - tag data
   #
   # Returns:
   #
   # Throws:
   def tag_end(var_Data)

     Common::Logger.print(Common::VAR_DEBUG, self, 
      "[TAG_END]: given data= [#{var_Data}] for current object name=["  + @VAR_CURRENT_OBJECT_NAME.to_s() +
      "], CMPX INDEX="                                                  + @VAR_COMPLEX_OBJECT_INDEX.to_s())
            
     if(@VAR_CURRENT_OBJECT_NAME == nil)
       Common::Logger.print(Common::VAR_DEBUG, self, 
        "[WARNING], closing not existing tag!"  + @VAR_COMPLEX_OBJECTS_NAMES[@VAR_COMPLEX_OBJECT_INDEX-1] + 
        ", "                                    + @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1].to_s())
        
        storeComplexObject(@VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1])
     else
       
       # If the copmlex object index is equal 0, it means that
       # there wasn't any complex object detected yet and the
       # current object is a simple object.
       if(@VAR_COMPLEX_OBJECT_INDEX == 0)
          Common::Logger.print(Common::VAR_DEBUG, self, "[TAG_END]: storing into SBAStore")
         
         storeObject(@VAR_CURRENT_OBJECT)
         
         @VAR_CURRENT_OBJECT_NAME = nil
         @VAR_CURRENT_OBJECT      = nil
       else
          Common::Logger.print(Common::VAR_DEBUG, self, "[TAG_END]: storing into array [" + @VAR_CURRENT_OBJECT.to_s() + "]")
  
          storeObject(@VAR_CURRENT_OBJECT)
         
          @VAR_CURRENT_OBJECT_NAME = nil
          @VAR_CURRENT_OBJECT      = nil
       end
     end
   end
   
   # Adds complex object to the array. 
   #
   # Params:
   #
   # var_Object:SBAComplexObject - complex object
   #
   # Returns:
   #
   # Throws:
   def addComplexObject(var_Object)
     
     Common::Logger.print(Common::VAR_DEBUG, self, "addig object [" + var_Object.to_s() + "] to the array list")
     
     if(!var_Object.is_a?(SBAStore::SBAComplexObject))
       raise SBATypeError.new("SBAStore::SBAComplexObject expected")
     end

     @VAR_COMPLEX_OBJECT_INDEX+=1
      
     # Add object to the array
     @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1] = var_Object
     @VAR_COMPLEX_OBJECTS_NAMES[@VAR_COMPLEX_OBJECT_INDEX-1] = var_Object.VAR_NAME
     @VAR_COMPLEX_OBJECTS_INDEXES[@VAR_COMPLEX_OBJECT_INDEX-1] = var_Object.VAR_ID
     
     # Add complex object to the previous complex object
     if(@VAR_COMPLEX_OBJECT_INDEX > 1)
       @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-2].add(var_Object.VAR_ID)
     end
     
     Common::Logger.print(Common::VAR_DEBUG, self, "puts [#{var_Object.to_s()}] to the array")   
   end
  
   # Puts given object to the SBA store. 
   #
   # Params:
   #
   # var_Object:SBAComplexObject - complex object
   #
   # Returns:
   #
   # Throws:
   def storeObject(var_Object)
    
     # Complex object can be added to the store on the end of its tag  
     if(var_Object.is_a?(SBAStore::SBAComplexObject))
       addComplexObject(var_Object)
     else
       # Add simple object to the previous complex object
       if(@VAR_COMPLEX_OBJECT_INDEX > 0)
         Common::Logger.print(Common::VAR_DEBUG, self, "addig simple object [" + var_Object.to_s() + "] to the complex object [" + @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1].to_s())
         
         @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1].add(var_Object.VAR_ID)
       end

       Common::Logger.print(Common::VAR_DEBUG, self, "addig simple object [" + var_Object.to_s() + "] to the store")
       
       #Store object in the SBAStore
       @VAR_STORE.add(var_Object)   
     end
   end

   # Puts complex object to the SBA store. 
   #
   # Params:
   #
   # var_Object:SBAComplexObject - complex object
   #
   # Returns:
   #
   # Throws:   
   def storeComplexObject(var_Object)
     
     if(!var_Object.is_a?(SBAStore::SBAComplexObject))
       raise SBATypeError.new(SBAStore::SBAComplexObject.class.to_s() + " expected")
     end
     
     if(@VAR_COMPLEX_OBJECT_INDEX == 0)
       raise InternalError.new("The complex object array list is empty [" + @VAR_COMPLEX_OBJECT_INDEX.to_s() + "]")
     end
     
     Common::Logger.print(Common::VAR_DEBUG, self, "addig complex object [" + var_Object.to_s() + "],[" + @VAR_COMPLEX_OBJECT_INDEX.to_s() + "] to the store")
     
      #Store object in the SBAStore
      @VAR_STORE.add(var_Object)
      
      # Revome the last complex object from the array list
      @VAR_COMPLEX_OBJECTS_NAMES[@VAR_COMPLEX_OBJECT_INDEX-1] = nil
      @VAR_COMPLEX_OBJECTS[@VAR_COMPLEX_OBJECT_INDEX-1] = nil
      @VAR_COMPLEX_OBJECT_INDEX-=1
   end
   
   # VAR_STORE:SBAStore - Complex object flag  
   attr :VAR_STORE
  
   # VAR_COMPLEX_OBJECTS:SBAObject - Array of the complex objects    
   attr :VAR_COMPLEX_OBJECTS
   
   # VAR_COMPLEX_OBJECTS_NAMES:String - Array of the complex objects' names
   attr :VAR_COMPLEX_OBJECTS_NAMES
    
   # VAR_COMPLEX_OBJECTS_INDEXES:Array of the complex object  
   attr :VAR_COMPLEX_OBJECTS_INDEXES
   
   # VAR_COMPLEX_OBJECT_INDEX:Integer - The current complex object's array index
   attr :VAR_COMPLEX_OBJECT_INDEX
   
   # VAR_CURRENT_OBJECT:SBAObject - Array of the complex objects    
   attr :VAR_CURRENT_OBJECT
   
   # VAR_CURRENT_OBJECT_NAME:String - Array of the complex objects' names
   attr :VAR_CURRENT_OBJECT_NAME

  end

end

