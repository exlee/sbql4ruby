module ParserLexerTest

require "test/unit"

require "rubygems"
require "ruby-debug"
#require "lib/Parser/SBQL.tab"
require 'YAML'
Dir["lib/QRES/*.rb"].each {|file| require file}
Dir["lib/Operator/*.rb"].each {|file| require file }
Dir["lib/AST/*.rb"].each {|file| require file }


    class ParserLexerTest < Test::Unit::TestCase
      include AST
      include QRES
      require "lib/Parser/ParserStringExtension"
      
        def setup
          Common::Logger.setLogLevel(Common::VAR_INFO)
          @AST = AST.new("sampledata/data.xml")
          
        end
        def execute(expression)
          expression.execute(@AST)
          @result = @AST.VAR_QRES().pop()
          
        end

        def test_SimpleExpression
            
            expression = SBQLParser.new.scan_str("2+(1)")
            self.execute(expression)
            
            assert(IntegerResult.new(3).equals(@result))
        end

        def test_operatorPrecedence
            expression = SBQLParser.new.scan_str("2+2*2")
            self.execute(expression)
            assert(IntegerResult.new(6).equals(@result))
        end

        def test_nameExpression
            expression = SBQLParser.new.scan_str("2+integer")
            self.execute(expression)
            assert_equal(IntegerResult.new(12), @result)
        end
        
        def test_structExpression
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.(fName,lName)")
            self.execute(expression)
          end

        end
        
        def test_simple_avgExpression
          expression = SBQLParser.new.scan_str("avg(1,2,3,4,5)")
          self.execute(expression)
          assert(IntegerResult.new(3).equals(@result), "Average 3 expected, got: " + @result.to_s)
          
        end
        
        def test_simple_and1
          expression = SBQLParser.new.scan_str("true and true")
          self.execute(expression)
          
          assert(BooleanResult.new(true).equals(@result))
        end
        
        def test_simple_and2
          expression = SBQLParser.new.scan_str("true and false")
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_simple_and3
          expression = SBQLParser.new.scan_str("false and true")
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_simple_and4
          expression = SBQLParser.new.scan_str("false and false")
          self.execute(expression)
          
          assert(BooleanResult.new(false).equals(@result))
        end
        
        def test_simple_as
          expression = SBQLParser.new.scan_str("1 as x")
          self.execute(expression)
          
          expected = BinderResult.new("x",IntegerResult.new(1))
          assert(expected.equals(@result), "1 as x -> Binder(x, 1)")          
        end
        
        def test_simple_bag
          expression = SBQLParser.new.scan_str("bag(1,2,3)")
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          assert(Utils::bagResultProxy(expected).equals(Utils::bagResultProxy(@result)), "Bag(1,2,3) -> BagResult(1,2,3)")
        end
        
        def test_simple_comma
          expression = SBQLParser.new.scan_str("1,2,3")
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          
          assert(Utils::bagResultProxy(expected).equals(Utils::bagResultProxy(@result)), "1,2,3 -> BagResult(1,2,3)")
        end
        
        def test_simple_different
          expression = SBQLParser.new.scan_str("1 != 3")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 != 3 -> BooleanResult(true)")
        end
        
        def test_simple_divide
          expression = SBQLParser.new.scan_str("10/5")
          self.execute(expression)
          
          expected = IntegerResult.new(2)
          assert(expected.equals(@result), "10/5 -> IntegerResult(2)")
        end
        
        def test_simple_dot
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.number")
            self.execute(expression)
          end
          
          
        end
        
        def test_simple_equal
          expression = SBQLParser.new.scan_str("2 == 2.0")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 == 2.0 -> BooleanResult(true)")
        end
        
        def test_simple_greater
          expression = SBQLParser.new.scan_str("2>1.5")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 > 1.5 -> BooleanResult(true)")
        end
        
        def test_simple_greaterequal
          expression = SBQLParser.new.scan_str("2>=2.0")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "2 >= 2.0 -> BooleanResult(true)")
        end
        
        def test_simple_groupas
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("Bag(1,2) as x")
            self.execute(expression)
          end
                
        end
        
        def test_simple_in
          expression = SBQLParser.new.scan_str("1 in Bag(1,2)")
            
            self.execute(expression)
            
            expected = BooleanResult.new(true)
            
            assert(expected.equals(@result), "1 in (1,2) -> BooleanResult(true)")
        end
        
        def test_simple_intersection
          expression = SBQLParser.new.scan_str("(1,2) intersect (2,3)")
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(2))
          
          assert(expected.equals(@result), "(1,2) intersect (2,3) -> BagResult(2)")
        end
        
        def test_simple_less
          expression = SBQLParser.new.scan_str("1 < 1.5")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 < 1.5 -> BooleanResult(true)")
        end
        
        def test_simple_lessequal
          expression = SBQLParser.new.scan_str("1 <= 1.0")
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          
          assert(expected.equals(@result), "1 <= 1.0 -> BooleanResult(true)")
        end
        
        def test_simple_max
          expression = SBQLParser.new.scan_str("Max(Bag(1,2,3))")
          self.execute(expression)
          
          expected = IntegerResult.new(3)
          
          assert(expected.equals(@result), "Max(1,2,3) -> IntegerResult(3)")
        end
        
        def test_simple_min
          expression = SBQLParser.new.scan_str("Min(Bag(1,2,3))")
          self.execute(expression)
          
          expected = IntegerResult.new(1)
          
          assert(expected.equals(@result), "Min(1,2,3) -> IntegerResult(1)")
        end
        
        def test_simple_minus
          expression = SBQLParser.new.scan_str("10-5")
          self.execute(expression)
          
          expected = IntegerResult.new(5)
          assert(expected.equals(@result), "10 - 5 -> IntegerResult(5)")
        end
        
        def test_simple_modulo
          expression = SBQLParser.new.scan_str("10 % 6")
          self.execute(expression)
          
          expected = IntegerResult.new(4)
          assert(expected.equals(@result), "10 % 6 -> IntegerResult(4)")
        end
        
        def test_simple_multiply
          expression = SBQLParser.new.scan_str("10 * 5")
          self.execute(expression)
          
          expected = IntegerResult.new(50)
          assert(expected.equals(@result), "10 * 5 -> IntegerResult(50)")
        end
        
        def test_simple_or1
          expression = SBQLParser.new.scan_str("true or false")
          
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_simple_or2
          expression = SBQLParser.new.scan_str("true or true")
          
          self.execute(expression)
          
          expected = BooleanResult.new(true)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_simple_or3
          expression = SBQLParser.new.scan_str("false or false")
          
          self.execute(expression)
          
          expected = BooleanResult.new(false)
          assert(expected.equals(@result), "true or false -> BooleanResult(true)")
        end
        
        def test_simple_plus
          expression = SBQLParser.new.scan_str("10 + 5")
          self.execute(expression)
          
          expected = IntegerResult.new(15)
          assert(expected.equals(@result), "10 + 5 -> IntegerResult(15)")
        end
        
        def test_simple_setminus
          expression = SBQLParser.new.scan_str("Bag(1,2) substract Bag(2,3)")
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          
          assert(expected.equals(@result), "(1,2) minus (2,3) -> BagResult(IntegerResult(1))")
        end
        
        def test_simple_struct
          expression = SBQLParser.new.scan_str("Struct(Bag(1,2))")
          
          self.execute(expression)
          
          expected = StructResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          
          assert(expected.equals(@result), "Struct(Bag(1,2)) -> StructResult(1,2)")
          
        end
        
        def test_simple_union
          expression = SBQLParser.new.scan_str("Bag(1,2) union Bag(2,3)")
          self.execute(expression)
          
          expected = BagResult.new()
          expected.push(IntegerResult.new(1))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(2))
          expected.push(IntegerResult.new(3))
          
          assert(expected.equals(@result), "(1,2) union (2,3) -> BagResult(1,2,2,3)")
        end
        
        def test_parser_1
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("bag(1,2,3)")
            self.execute(expression)
          end
        end
        
        def test_parser_2
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("struct(1,2,3)")
            self.execute(expression)
          end
        end
        
        def test_parser_3
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("bag(1, bag(2,3))")
            self.execute(expression)
          end
        end
        
        def test_parser_4
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp where fName=\"Anna\"")
            self.execute(expression)
          end
        end
        
        def test_parser_5
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.address where city=\"Warszawa\"")
            self.execute(expression)
          end
        end
        
        def test_parser_6
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((osoba where married).book.author)")
            self.execute(expression)
          end
        end
        
        def test_parser_7
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((osoba where fName=\"Maciej\").address.street)")
            self.execute(expression)
          end
        end
        
        def test_parser_8
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((osoba.adress) where numer=50).(street)")
            self.execute(expression)
          end
        end
        
        def test_parser_9
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((osoba.adress) where kod=\"00-222\").(city)")
            self.execute(expression)
          end
        end
        
        def test_parser_10
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((emp where married).book.author) union (test)")
            self.execute(expression)
          end
        end
        
        def test_parser_11
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((emp where fName=\"Maciej\").address.street)")
            self.execute(expression)
          end
        end
        
        def test_parser_12
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("((emp.adress) where number > 20).(street,city)")
            self.execute(expression)
          end
        end
        
        def test_parser_13
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp as e join (dept where dept_id=e.dept_id)")
            self.execute(expression)
          end
        end
        
        def test_parser_14
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("(dept as d join (max((emp where dept_id=d.dept_id).salary) as maxSal)).(d.name,maxSal)")
            self.execute(expression)
          end
        end
        
        def test_parser_15
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("(dept as d join (avg((emp where dept_id=d.dept_id).salary) as avgSal)).(d.name,avgSal)")
            self.execute(expression)
          end
        end
        
        def test_parser_16
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp substract (emp where salary = max(emp.salary) or salary = min(emp.salary))")
            self.execute(expression)
          end
        end
        
        def test_parser_17
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp where salary < avg(emp.salary)")
            self.execute(expression)
          end
        end
        
        def test_parser_18
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp join dept")
            self.execute(expression)
          end
        end
        
        def test_parser_19
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp,dept")
            self.execute(expression)
          end
        end
        
        def test_parser_20
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.(fName,lName, salary/avg(emp.salary) * 100 as SalaryAvgRel)")
            self.execute(expression)
          end
        end
        
        def test_parser_21
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.(fName,lName, salary/min(emp.salary) * 100 as SalaryMinRel)")
            self.execute(expression)
          end
        end
        
        def test_parser_22
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.(fName,lName, salary/max(emp.salary) * 100 as SalaryMinRel)")
            self.execute(expression)
          end
        end
        
        def test_parser_23
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("\"Hello\" + \" \" + \"World!\"")
            self.execute(expression)
          end
        end
        
        def test_parser_24
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("\"Hello\" + \" \" + \"World!\" as text")
            self.execute(expression)
          end
        end
        
    end
end
