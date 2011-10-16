module ENVS

require "test/unit"

require "lib/ENVS/Frame"


  class ENVSTest < Test::Unit::TestCase
  
    # Creates few SBA objects and puts those to the store.
    #
    # Params:
    #
    # Returns:
    #
    # Throws:   
    def test_SBAStore
      
      assert_nothing_thrown("Creating SBA objects") {  
        frame = Frame.new()
        
        puts "Test=" + frame.to_s()
      }
    end
    
  end
       
end
