module BagProxyTest

require "test/unit"
require "lib/Common/Logger"

Dir["lib/QRES/*.rb"].each {|file| require file }
Dir["lib/Operator/*.rb"].each {|file| require file }
Dir["lib/AST/*.rb"].each {|file| require file }


    class BagProxyTest < Test::Unit::TestCase
        include AST
        include QRES
        def setup
          Common::Logger.setLogLevel(Common::VAR_INFO)
          @AST = AST.new("sampledata/data.xml")
          
        end
        
        def execute(expression)
          expression.execute(@AST)
          @result = @AST.VAR_QRES().pop()
        end
        
        def test_bagProxyNoConversion
          bagResult = BagResult.new()
          
          bagResult.push(IntegerResult.new(1))
          bagResult.push(IntegerResult.new(2))
          bagResult.push(IntegerResult.new(3))
          
          assert(bagResult.equals(Utils::bagResultProxy(bagResult)))
        end
        
        def test_bagProxyNoConversionWithStruct
          bagResult       = BagResult.new()
          structResult    = StructResult.new()
          extectedResult  = BagResult.new()

          structResult.push(IntegerResult.new(1))
          structResult.push(IntegerResult.new(2))
          structResult.push(IntegerResult.new(3))
          
          bagResult.push(structResult)
          bagResult.push(structResult)

          assert(bagResult.equals(Utils::bagResultProxy(bagResult)))
        end

        def test_bagProxyConversion
          bagResult       = BagResult.new()
          structResult    = StructResult.new()
          extectedResult  = BagResult.new()
          
          structResult.push(IntegerResult.new(1))
          structResult.push(IntegerResult.new(2))
          structResult.push(IntegerResult.new(3))
          
          bagResult.push(structResult)
             
          # Expected result     
          extectedResult = BagResult.new()
          
          extectedResult.push(IntegerResult.new(1))
          extectedResult.push(IntegerResult.new(2))
          extectedResult.push(IntegerResult.new(3))
          
          assert(extectedResult.equals(Utils::bagResultProxy(bagResult)))
        end        
       
        def test_bagProxyConversionPop
          bagResult       = BagResult.new()
          structResult    = StructResult.new()
          extectedResult  = BagResult.new()
          
          structResult.push(IntegerResult.new(1))
          structResult.push(IntegerResult.new(2))
          structResult.push(IntegerResult.new(3))
          
          bagResult.push(structResult)
          
          bagResult.pop()
          
          # Expected result     
          extectedResult = BagResult.new()
          
          extectedResult.push(IntegerResult.new(1))
          extectedResult.push(IntegerResult.new(2))
           
          assert(extectedResult.equals(Utils::bagResultProxy(bagResult)))
          
          bagResult.pop()
          extectedResult.pop()
         
          assert(extectedResult.equals(Utils::bagResultProxy(bagResult))) 
        end
        
        def test_bagProxyIsSimpleResult
          bagResult       = BagResult.new()
          structResult    = StructResult.new()
          
          structResult.push(IntegerResult.new(1))
          structResult.push(IntegerResult.new(2))
          structResult.push(IntegerResult.new(3))
          
          bagResult.push(structResult)

          assert_equal(false, bagResult.isSimpleObject?())
          
          bagResult.pop()
          bagResult.pop()
          
          assert_equal(true, bagResult.isSimpleObject?())
        end

        def test_bagProxyGetAsSimpleResult
          bagResult       = BagResult.new()
          structResult    = StructResult.new()
          
          structResult.push(IntegerResult.new(1))
          
          bagResult.push(structResult)

          # Expected result     
          extectedResult = IntegerResult.new(1)
          
          assert(extectedResult.equals(bagResult.getAsSimpleResult()))           
        end
    end
end