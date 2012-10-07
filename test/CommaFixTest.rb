module CommaFixTest

require "test/unit"
require "lib/Common/Logger"

Dir["lib/QRES/*.rb"].each {|file| require file }
Dir["lib/Operator/*.rb"].each {|file| require file }
Dir["lib/AST/*.rb"].each {|file| require file }


    class ParserLexerTest < Test::Unit::TestCase
        include AST
        include QRES
        def setup
          Common::Logger.setLogLevel(Common::VAR_DEBUG)
          @AST = AST.new("sampledata/data.xml")
          
        end
        
        def execute(expression)
          expression.execute(@AST)
          @result = @AST.VAR_QRES().pop()
        end
        
        def test_SimpleSimple
          expression = CommaExpression.new(IntegerTerminal.new(1),IntegerTerminal.new(2))

          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
  
          # 1,2 = b(1,2)
          assert(expected.equals(Utils::bagResultProxy(@result)), "1,2 -> BagResult(1,2)")
        end
        
        def test_SimpleBag
          expression = CommaExpression.new(
            IntegerTerminal.new(1),
            CommaExpression.new(
              IntegerTerminal.new(2),
              IntegerTerminal.new(3)
            )
          )

          self.execute(expression)

          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))

          # 1,b(2,3) = b(1,2,3)
          assert(expected.equals(Utils::bagResultProxy(@result)), "1,b(2,3) -> BagResult(1,2,3)")
         end
         
        def test_BagSimple
          expression = CommaExpression.new(
            CommaExpression.new(
              IntegerTerminal.new(1),
              IntegerTerminal.new(2)
            ),
            IntegerTerminal.new(3)
          )

          self.execute(expression)

          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))

          # b(1,2),3 = b(1,2,3)
          assert(expected.equals(Utils::bagResultProxy(@result)), "b(1,2),3-> BagResult(1,2,3)")
        end
        
        def test_BagBag
          expression = CommaExpression.new(
            CommaExpression.new(
              IntegerTerminal.new(1),
              IntegerTerminal.new(2)
            ),
            CommaExpression.new(
              IntegerTerminal.new(3),
              IntegerTerminal.new(4)
            )
          )

          self.execute(expression)

          expected = BagResult.new()
          
          struct1 = StructResult.new()
          struct1.push(IntegerResult.new(1))
          struct1.push(IntegerResult.new(3))
          
          struct2 = StructResult.new()
          struct2.push(IntegerResult.new(1))
          struct2.push(IntegerResult.new(4))

          struct3 = StructResult.new()
          struct3.push(IntegerResult.new(2))
          struct3.push(IntegerResult.new(3))

          struct4 = StructResult.new()
          struct4.push(IntegerResult.new(2))
          struct4.push(IntegerResult.new(4))

          expected.push(struct1)
          expected.push(struct2)
          expected.push(struct3)
          expected.push(struct4)
          
          # b(1,2), b(3,4) = b(s(1,3),s(1,4),s(2,3),s(2,4))
          assert(expected.equals(@result), "b(1,2), b(3,4) -> BagResult(StructResult(1,3),StructResult(1,4),StructResult(2,3),StructResult(2,4))")
        end
    
        def test_BagStruct
          expression = CommaExpression.new(
            CommaExpression.new(
              IntegerTerminal.new(1),
              IntegerTerminal.new(2)
            ),
            StructExpression.new(CommaExpression.new(IntegerTerminal.new(3), IntegerTerminal.new(4)))
          )

          #expression = StructExpression.new(CommaExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(2)))
          self.execute(expression)

          expected = BagResult.new()
          
          struct1 = StructResult.new()
          struct1.push(IntegerResult.new(1))
          struct1.push(IntegerResult.new(2))
          
          struct2 = StructResult.new()
          struct2.push(IntegerResult.new(3))
          struct2.push(IntegerResult.new(4))

          expected.push(struct1)
          expected.push(struct2)
          
          # b(1,2), s(3,4) = b(s(1,2),s(3,4))
          assert(expected.equals(@result), "b(1,2), s(3,4) = b(s(1,2),s(3,4))")
        end

        def test_StructSimlpe
          expression = CommaExpression.new(
            StructExpression.new(CommaExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(2))),
            IntegerTerminal.new(3)
          )

          #expression = StructExpression.new(CommaExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(2)))
          self.execute(expression)

          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          
          # s(1,2),3 = b(1,2,3)
          assert(expected.equals(Utils::bagResultProxy(@result)), "s(1,2),3 -> BagResult(1,2,3)")
        end
        
        def test_StructStruct
          expression = CommaExpression.new(
            StructExpression.new(CommaExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(2))),
            StructExpression.new(CommaExpression.new(IntegerTerminal.new(3), IntegerTerminal.new(4)))
          )

          #expression = StructExpression.new(CommaExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(2)))
          self.execute(expression)

          #expected = StructResult.new()
          #expected.push(IntegerResult.new(1))
          #expected.push(IntegerResult.new(2))
          #expected.push(IntegerResult.new(3))
          
          # s(1,2),s(3,4) = b(s(1,2,3,4))
          
          assert(expected.equals(Utils::bagResultProxy(@result)), "s(1,2),3 -> StructResult(1,2,3)")
        end
    end
end