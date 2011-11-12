module SBAStore

require "test/unit"

require "lib/SBAStore/SBAInteger"
require "lib/SBAStore/SBAFloat"
require "lib/SBAStore/SBABoolean"
require "lib/SBAStore/SBAString"
require "lib/SBAStore/SBAStore"
require "lib/SBAStore/SBASimpleObjectFactory"
require "lib/SBAStore/SBAComplexObject"
require "lib/SBAStore/SBAComplexObjectIterator"
  

  class SBAStoreTest < Test::Unit::TestCase
  
    # Creates few SBA objects and puts those to the store.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_SBAStore
      
      assert_nothing_thrown("Creating SBA objects") {  
        store = SBAStore.new();
        
        store.add(SBASimpleObjectFactory.create("Integer object test", "123"))
        store.add(SBASimpleObjectFactory.create("Float object test", "123.123"))
        store.add(SBASimpleObjectFactory.create("String object test", "TEST"))
        store.add(SBASimpleObjectFactory.create("Boolean object test", "true"))
        
        complexObject = SBAComplexObject.new("Complex test object")
        complexObject.add(0)
        
        for i in 1..100
          complexObject.push(i)
        end
        
        store.add(complexObject)
        
        assert_equal(5, store.VAR_OBJECTS.size())
        
        assert_equal("Complex test object", store.VAR_OBJECTS[4].VAR_NAME.to_s())
        assert_equal(101, store.VAR_OBJECTS[4].VAR_OBJECT.size())
        assert_equal(0, store.VAR_OBJECTS[4].VAR_OBJECT[0])
        
        assert_equal("TEST", store.find(2).VAR_OBJECT)
      }
    end
    
  end
       
end
