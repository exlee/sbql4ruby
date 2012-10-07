module FlowTest

require "test/unit"
require "lib/Common/Logger"
require 'YAML'

Dir["lib/QRES/*.rb"].each {|file| require file }
Dir["lib/Operator/*.rb"].each {|file| require file }
Dir["lib/AST/*.rb"].each {|file| require file }


    class ParserLexerTest < Test::Unit::TestCase
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
        
        def test_and1
          expression = AndExpression.new(BooleanTerminal.new(true), BooleanTerminal.new(true))
          self.execute(expression)
          
          assert(BooleanResult.new(true).equals(@result))
        end
        
        def test_and2
          expression = AndExpression.new(BooleanTerminal.new(true), BooleanTerminal.new(false))
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_and3
          expression = AndExpression.new(BooleanTerminal.new(false), BooleanTerminal.new(false))
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_and4
          expression = AndExpression.new(BooleanTerminal.new(false), BooleanTerminal.new(true))
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_as
          expression = AsExpression.new(IntegerTerminal.new(1), "x")
          self.execute(expression)
          
          expected = BinderResult.new("x",IntegerResult.new(1))
          assert(expected.equals(@result))          
        end
        
        def test_bag
          expression = BagExpression.new(
            CommaExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(1),
                IntegerTerminal.new(2)
              ),
              IntegerTerminal.new(3)
            )
          )
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          
          puts "AAA #{Utils::bagResultProxy(@result)}"
          
          assert(expected.equals(Utils::bagResultProxy(@result)), "Bag(1,2,3) -> BagResult(1,2,3)")
        end
        
        def test_comma
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
          
          assert(Utils::bagResultProxy(expected).equals(Utils::bagResultProxy(@result)), "1,2,3 -> BagResult(1,2,3)")
        end
        
        def test_different
          expression = DifferentExpression.new(IntegerTerminal.new(1), IntegerTerminal.new(3))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 != 3 -> BooleanResult(true)")
        end
        
        def test_divide
          expression = DivideExpression.new(IntegerTerminal.new(10), IntegerTerminal.new(5))
          self.execute(expression)
          
          expected = IntegerResult.new(2)
          assert(expected.equals(@result), "10/5 -> IntegerResult(2)")
        end
        
        def test_dot
          expression = DotExpression.new(NameExpression.new("emp"), NameExpression.new("number"))
          self.execute(expression)
          
          #TODO: Do weryfikacji
          
        end
        
        def test_equal
          expression = EqualExpression.new(IntegerTerminal.new(2), FloatTerminal.new(2.0))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 == 2.0 -> BooleanResult(true)")
        end
        
        def test_greater
          expression = GreatherExpression.new(IntegerTerminal.new(2), FloatTerminal.new(1.5))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 > 1.5 -> BooleanResult(true)")
        end
        
        def test_greaterequal
          expression = GreatherEqualExpression.new(IntegerTerminal.new(2), FloatTerminal.new(2.0))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 >= 2.0 -> BooleanResult(true)")
        end
        
        def test_groupas
          # TODO: Do dopisania jak będzie wiadomo jak
          expression =
            GroupAsExpression.new(
              BagExpression.new(
                CommaExpression.new(
                  IntegerTerminal.new(1),
                  IntegerTerminal.new(2)
                )
              ),
              "x"
            )
            self.execute(expression)
                
        end
        
        def test_in
          expression = 
            InExpression.new(
              IntegerTerminal.new(1),
              BagExpression.new(
                CommaExpression.new(
                  IntegerTerminal.new(1),
                  IntegerTerminal.new(2)
                )
              )
            )
            
            self.execute(expression)
            
            expected = BooleanResult.new(true)
            
            assert(expected.equals(@result), "1 in (1,2) -> BooleanResult(true)")
        end
        
        def test_intersection
          expression = 
          IntersectExpression.new(
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(1),
                IntegerTerminal.new(2)
              )
            ),
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(2),
                IntegerTerminal.new(3)
              )
            )
          )
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(2))
          
          assert(expected.equals(@result), "(1,2) intersect (2,3) -> BagResult(2)")
        end
        
        def test_join
          # Cannot be tested as for now
        end
        
        def test_less
          expression = LessExpression.new(IntegerTerminal.new(1), FloatTerminal.new(1.5))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 < 1.5 -> BooleanResult(true)")
        end
        
        def test_lessequal
          expression = LessEqualExpression.new(IntegerTerminal.new(1), FloatTerminal.new(1.0))
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 <= 1.0 -> BooleanResult(true)")
        end
        
        def test_max
          expression = MaxExpression.new(
            BagExpression.new(
              CommaExpression.new(
                CommaExpression.new(
                  IntegerTerminal.new(1),
                  IntegerTerminal.new(2)
                ),
                IntegerTerminal.new(3)
              )
            )
          )
          self.execute(expression)
          
          expected = IntegerResult.new(3)
          
          assert(expected.equals(@result), "Max(1,2,3) -> IntegerResult(3)")
        end
        
        def test_min
          expression = MinExpression.new(
            BagExpression.new(
              CommaExpression.new(
                CommaExpression.new(
                  IntegerTerminal.new(1),
                  IntegerTerminal.new(2)
                ),
                IntegerTerminal.new(3)
              )
            )
          )
          self.execute(expression)
          
          expected = IntegerResult.new(1)
          
          assert(expected.equals(@result), "Min(1,2,3) -> IntegerResult(1)")
        end
        
        def test_minus
          expression = MinusExpression.new(IntegerTerminal.new(10), IntegerTerminal.new(5))
          self.execute(expression)
          
          expected = IntegerResult.new(5)
          assert(expected.equals(@result), "10 - 5 -> IntegerResult(5)")
        end
        
        def test_modulo
          expression = ModuloExpression.new(IntegerTerminal.new(10), IntegerTerminal.new(6))
          self.execute(expression)
          
          expected = IntegerResult.new(4)
          assert(expected.equals(@result), "10 % 6 -> IntegerResult(4)")
        end
        
        def test_multiply
          expression = MultiplyExpression.new(IntegerTerminal.new(10), IntegerTerminal.new(5))
          self.execute(expression)
          
          expected = IntegerResult.new(50)
          assert(expected.equals(@result), "10 * 5 -> IntegerResult(50)")
        end
        
        def test_or1
          expression = OrExpression.new(
            BooleanTerminal.new(true),
            BooleanTerminal.new(false)
          )
          
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_or2
          expression = OrExpression.new(
            BooleanTerminal.new(true),
            BooleanTerminal.new(true)
          )
          
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_or3
          expression = OrExpression.new(
            BooleanTerminal.new(false),
            BooleanTerminal.new(false)
          )
          
          self.execute(expression)
          
          expected = BooleanResult.new(false)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_orderby
          #TODO: Cannot be tested right now
        end
        
        def test_plus
          expression = PlusExpression.new(IntegerTerminal.new(10), IntegerTerminal.new(5))
          self.execute(expression)
          
          expected = IntegerResult.new(15)
          assert(expected.equals(@result), "10 + 5 -> IntegerResult(15)")
        end
        
        def test_setminus
          expression = 
          SetMinusExpression.new(
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(1),
                IntegerTerminal.new(2)
              )
            ),
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(2),
                IntegerTerminal.new(3)
              )
            )
          )
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          
          assert(expected.equals(@result), "(1,2) minus (2,3) -> BagResult(IntegerResult(1))")
        end
        
        def test_struct
          expression = StructExpression.new(
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(1),
                IntegerTerminal.new(2)
              )
            )
          )
          
          self.execute(expression)
          
          expected = StructResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          
          assert(expected.equals(@result), "Struct(Bag(1,2)) -> StructResult(1,2)")
          
        end
        
        def test_union
          expression = 
          UnionExpression.new(
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(1),
                IntegerTerminal.new(2)
              )
            ),
            BagExpression.new(
              CommaExpression.new(
                IntegerTerminal.new(2),
                IntegerTerminal.new(3)
              )
            )
          )
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          
          assert(expected.equals(@result), "(1,2) union (2,3) -> BagResult(1,2,2,3)")
        end
        
        def test_where
          #TODO: Cannot be tested as for now
        end
        
        def test_pickrandom
          #TODO: Cannot be tested as for now
        end
        
        def test_orderbydesc
          #TODO: Cannot be tested as for now
        end
    end
end