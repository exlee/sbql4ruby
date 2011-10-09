module SBAStore

require "test/unit"


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
        require "lib/SBAStore/SBAInteger"
        require "lib/SBAStore/SBAFloat"
        require "lib/SBAStore/SBABoolean"
        require "lib/SBAStore/SBAString"
        require "lib/SBAStore/SBAStore"
        require "lib/SBAStore/SBASimpleObjectFactory"
        require "lib/SBAStore/SBAComplexObject"
        
        store = SBAStore.new();
        store.add(SBASimpleObjectFactory.create("Integer object test", "123"));
        store.add(SBASimpleObjectFactory.create("Float object test", "123.123"));
        store.add(SBASimpleObjectFactory.create("String object test", "TEST"));
        store.add(SBASimpleObjectFactory.create("Boolean object test", "true"));
        
        complexObject = SBAComplexObject.new("Complex test object")
        complexObject.add(10)
        
        store.add(complexObject)
        
        puts "Found object=[" + store.get(0).to_s() + "]"
        puts "Found object=[" + store.find(1).to_s() + "]"
      }
    end
    
  end
       
end
