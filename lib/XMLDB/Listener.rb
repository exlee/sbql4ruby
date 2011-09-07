module XMLDB
  
require 'rexml/document'
require 'rexml/streamlistener'
 
require "exceptions"

require "SBAComplexObject"
require "SBASimpleObjectFactory"

include REXML


  class Listener 
    include REXML::StreamListener
    
    @@VAR_ROOT_TAG            = "root"
   
    # Method:initialize
    #
    # Params:
    #
    # var_Store:SBAStore - SBA store
    #
    # Returns:
    #
    # Throws:SBATypeError
    def initialize(var_Store)
      @VAR_STORE = var_Store
      
      # The array of complex objects which are not
      # currently added to the store (their tags
      # are not closed).
      @VAR_COMPLEX_OBJECTS          = Array.new()
      @VAR_COMPLEX_OBJECTS_NAMES    = Array.new()
      @VAR_COMPLEX_OBJECTS_INDEXES  = Array.new()
      
      @VAR_COMPLEX_OBJECT_INDEX     = 0
      
      @VAR_CURRENT_OBJECT           = nil
      @VAR_CURRENT_OBJECTS_NAME     = nil
    end
    
    # Method:tag_start
    #
    # Used by XML parser if notifies beginning
    # of a new tag. 
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
      
      puts  "TAG_START: given tag name = ["       + var_TagName + 
            "], existing current object name = [" + @VAR_CURRENT_OBJECT_NAME.to_s() +
            "], CMPX INDEX="                      + @VAR_COMPLEX_OBJECT_INDEX.to_s()
      
      if(@VAR_COMPLEX_OBJECTS_INDEXES == 0)  
         
        # First object in the store
        @VAR_CURRENT_OBJECT = nil
        @VAR_CURRENT_OBJECT_NAME = var_TagName
        
        puts "TAG_START: First object in the XML file = [" + @VAR_CURRENT_OBJECT_NAME + "]"       
        
      else
       
        if(@VAR_CURRENT_OBJECT == nil)
          
          @VAR_CURRENT_OBJECT = SBAStore::SBAComplexObject.new(@VAR_CURRENT_OBJECT_NAME)
          addComplexObject(@VAR_CURRENT_OBJECT)
        
        end
        
        @VAR_CURRENT_OBJECT = nil
        @VAR_CURRENT_OBJECT_NAME = var_TagName
          
        puts "TAG_START: Next object in the XML file = [" + @VAR_CURRENT_OBJECT_NAME + "]"   
               
      end
    end
  
    def text(data)
     return if data =~ /^\W*$/

     puts  "TAG_DATA: given data= [#{data}] for current object name=["  + @VAR_CURRENT_OBJECT_NAME.to_s() +
           "], CMPX INDEX="                                             + @VAR_COMPLEX_OBJECT_INDEX.to_s()
          
     @VAR_CURRENT_OBJECT = SBAStore::SBASimpleObjectFactory.create(@VAR_CURRENT_OBJECT_NAME, data);
     
     puts "TAG_DATA: current object=" + @VAR_CURRENT_OBJECT.to_s()
     
     #abbrev = data[0..40] + (data.length > 40 ? "..." : "")
    
     #puts "  text   :   #{abbrev.inspect}"
     
     # jeżeli jest wartość:
     #do nazwy dodaj wartość, spróbuj zrobić rzutowanie
     #Jeżeli ok to simple, jeżeli nie to wyjątek
   end
   
   def tag_end(data)
     
     puts   "TAG_END: given data= [#{data}] for current object name=["  + @VAR_CURRENT_OBJECT_NAME.to_s() +
            "], CMPX INDEX="                                             + @VAR_COMPLEX_OBJECT_INDEX.to_s()
            
     if(@VAR_CURRENT_OBJECT_NAME == nil)
       puts "ERROR, closing not existing tag!"
     else
       # Current object has registered name, but it hasn't any value,
       # so next object will be registered as attribute.
       if(@VAR_CURRENT_OBJECT == nil)
         @VAR_CURRENT_OBJECT = SBAStore::SBAComplexObject.new()
       end
       
       # If the copmlex object index is equal 0, it means that
       # there wasn't any complex object detected yet and the
       # current object is a simple object.
       if(@VAR_COMPLEX_OBJECT_INDEX == 0)
         puts "TAG_END: storing into SBAStore"
         
         storeObject(@VAR_CURRENT_OBJECT)
         
         @VAR_CURRENT_OBJECT_NAME = nil
         @VAR_CURRENT_OBJECT      = nil
       else
         puts "TAG_END: storing into array"
         
         storeObject(@VAR_CURRENT_OBJECT)
         addComplexObject(@VAR_CURRENT_OBJECT)
         
          @VAR_CURRENT_OBJECT_NAME = nil
          @VAR_CURRENT_OBJECT      = nil
       end
     end
   end
   
   def addComplexObject(var_Object)
     
     # Add object to the array
     @VAR_COMPLEX_OBJECTS.push(var_Object)
     @VAR_COMPLEX_OBJECTS_NAMES.push(var_Object)
     @VAR_COMPLEX_OBJECTS_INDEXES.push(var_Object.VAR_ID)
     
     # Add complex object to the previous complex object
     if(SBAComplexObject.is_a?(var_Object) && VAR_COMPLEX_OBJECT_INDEX > 0)
       @VAR_COMPLEX_OBJECTS[VAR_COMPLEX_OBJECT_INDEX-1].add(var_Object.VAR_ID)
     end
      
     @VAR_COMPLEX_OBJECT_INDEX+=1
     
     puts "addComplexObject: puts [#{var_Object.to_s()}] to the array"
     
   end
  
   def storeObject(var_Object)
     
     # Store object's identifier in the last complex object
     if(SBASimpleObjectFactory.isValidSBAType?(var_Object))
       
       @VAR_COMPLEX_OBJECTS[VAR_COMPLEX_OBJECT_INDEX-1].add(var_Object.VAR_ID)
       @VAR_STORE.add(var_Object)
     end
     
     #Store object in the SBAStore
     @VAR_STORE.add(var_Object)
     
     # Clean references
     @VAR_CURRENT_OBJECT = nil
     @VAR_CURRENT_OBJECT_NAME = nil
     
     puts "storeObject: puts [#{var_Object.to_s()}] to the store"
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
   attr :VAR_CURRENT_OBJECT

  end

end

