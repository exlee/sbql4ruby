module SBAStore

$:<< "/Users/mqs74/Dropbox/Workspace/sbql4ruby/lib/SBAStore"

require "test/unit"

  class SBAStoreTest < Test::Unit::TestCase
 
    def test_SBAStore
      #puts $:
      assert_nothing_thrown("Creating SBA objects") {
        require "SBAInteger"
        require "SBAFloat"
        require "SBABoolean"
        require "SBAString"
        require "SBAStore"
        require "SBASimpleObjectFactory"
        
        store = SBAStore.new();
        store.add(SBASimpleObjectFactory.create("Integer object test", 123));
        store.add(SBASimpleObjectFactory.create("Float object test", 123.123));
        store.add(SBASimpleObjectFactory.create("String object test", "TEST"));
        store.add(SBASimpleObjectFactory.create("Boolean object test", true));
      }
    end
    
  end
       
end
