module ParserLexerTest

require "test/unit"

require "rubygems"
require "ruby-debug"
require 'YAML'
Dir["lib/QRES/*.rb"].each {|file| require file }
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
        # Test for basic object flow (initializing object etc. based on 
        # empty expression.
        #
        # Params:
        #
        # Returns:
        #
        # Throws:

        def test_SimpleExpression
            
            expression = SBQLParser.new.scan_str("2+(1)")
            self.execute(expression)
            expected = "3"
            assert_equal(expected,@result.print(@AST.VAR_STORE))
        end

        def test_operatorPrecedence
            expression = SBQLParser.new.scan_str("2+2*2")
            self.execute(expression)
            expected = "6"
            assert_equal(expected,@result.print(@AST.VAR_STORE))
        end

        def test_nameExpression
            expression = SBQLParser.new.scan_str("2+integer")
            self.execute(expression)
            expected = "12"
            assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_emp
            expression = SBQLParser.new.scan_str("emp")
            self.execute(expression)
            expected = "bag([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]],[s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false],[s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false],[s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true])"
            assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_structExpression
          assert_nothing_thrown do
            expression = SBQLParser.new.scan_str("emp.(fName,lName)")
            self.execute(expression)
            expected = "bag(struct([Anna],[Kowalska]),struct([Maciej],[Nowak]),struct([Łukasz],[Wiśniewski]),struct([Marzena],[Ignasiewicz]))"
            assert_equal(expected,@result.print(@AST.VAR_STORE))
          end

        end
        
        def test_simple_avgExpression
          expression = SBQLParser.new.scan_str("avg(1,2,3,4,5)")
          self.execute(expression)
          expected = "3.0"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
          
        end
        
        def test_simple_and1
          expression = SBQLParser.new.scan_str("true and true")
          self.execute(expression)
          expected = "true"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_and2
          expression = SBQLParser.new.scan_str("true and false")
          self.execute(expression)
          expected = "false"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_and3
          expression = SBQLParser.new.scan_str("false and true")
          self.execute(expression)
          expected = "false"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_and4
          expression = SBQLParser.new.scan_str("false and false")
          self.execute(expression)
          expected = "false"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_as
          expression = SBQLParser.new.scan_str("1 as x")
          self.execute(expression)
          
          expected = "(1) as x"
          assert_equal(expected,@result.print(@AST.VAR_STORE))  
        end
        
        def test_simple_bag
          expression = SBQLParser.new.scan_str("bag(1,2,3)")
          self.execute(expression)
          
          expected = "bag(1,2,3)"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
       end
        
        def test_simple_comma
          expression = SBQLParser.new.scan_str("1,2,3")
          self.execute(expression)
          
          expected = "bag(1,2,3)"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_different
          expression = SBQLParser.new.scan_str("1 != 3")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_divide
          expression = SBQLParser.new.scan_str("13/2")
          self.execute(expression)
          
          expected = "6.5"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_dot
          
          expression = SBQLParser.new.scan_str("emp.number")
          self.execute(expression)
          expected = "bag([s0000],[s0001],[s0002],[s0003])"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
          
        end
        
        def test_simple_equal
          expression = SBQLParser.new.scan_str("2 == 2.0")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_greater
          expression = SBQLParser.new.scan_str("2>1.5")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_greaterequal
          expression = SBQLParser.new.scan_str("2>=2.0")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_groupas
          expression = SBQLParser.new.scan_str("Bag(1,2) group as x")
          self.execute(expression)
          expected = "(bag(1,2)) as x"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
                
        end
        
        def test_simple_in
          expression = SBQLParser.new.scan_str("1 in Bag(1,2)")
            
            self.execute(expression)
            
            expected = "true"
            
            assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_intersection
          expression = SBQLParser.new.scan_str("(1,2) intersect (2,3)")
          self.execute(expression)
          
          expected = "2"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_less
          expression = SBQLParser.new.scan_str("1 < 1.5")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_lessequal
          expression = SBQLParser.new.scan_str("1 <= 1.0")
          self.execute(expression)
          
          expected = "true"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_max
          expression = SBQLParser.new.scan_str("Max(Bag(1,2,3))")
          self.execute(expression)
          
          expected = "3"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_min
          expression = SBQLParser.new.scan_str("Min(Bag(1,2,3))")
          self.execute(expression)
          
          expected = "1"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_minus
          expression = SBQLParser.new.scan_str("10-5")
          self.execute(expression)
          
          expected = "5"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_modulo
          expression = SBQLParser.new.scan_str("10 % 6")
          self.execute(expression)
          
          expected = "4.0"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_multiply
          expression = SBQLParser.new.scan_str("10 * 5")
          self.execute(expression)
          
          expected = "50"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_or1
          expression = SBQLParser.new.scan_str("true or false")
          
          self.execute(expression)
          
          expected = "true"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_or2
          expression = SBQLParser.new.scan_str("true or true")
          
          self.execute(expression)
          
          expected = "true"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_or3
          expression = SBQLParser.new.scan_str("false or false")
          
          self.execute(expression)
          
          expected = "false"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_plus
          expression = SBQLParser.new.scan_str("10 + 5")
          self.execute(expression)
          
          expected = "15"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_setminus
          expression = SBQLParser.new.scan_str("Bag(1,2) substract Bag(2,3)")
          self.execute(expression)
          
          expected = "1"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_simple_struct
          expression = SBQLParser.new.scan_str("Struct(Bag(1,2))")
          
          self.execute(expression)
          
          expected = "struct(1,2)"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
          
        end
        
        def test_simple_union
          expression = SBQLParser.new.scan_str("Bag(1,2) union Bag(2,3)")
          self.execute(expression)
          
          expected = "bag(1,2,2,3)"
          
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_1
          
          expression = SBQLParser.new.scan_str("bag(1,2,3)")
          self.execute(expression)
          expected = "bag(1,2,3)"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_2
          expression = SBQLParser.new.scan_str("struct(1,2,3)")
          self.execute(expression)
          expected = "struct(1,2,3)"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_3
          expression = SBQLParser.new.scan_str("bag(1, bag(2,3))")
          self.execute(expression)
          expected = "bag(1,2,3)"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_4
          expression = SBQLParser.new.scan_str("emp where fName=\"Anna\"")
          self.execute(expression)
          expected = "[s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_5
          expression = SBQLParser.new.scan_str("emp.address where city=\"Warszawa\"")
          self.execute(expression)
          expected = "bag([al. Jerozolimskie,50,00-111,Warszawa],[Koszykowa,86,00-222,Warszawa])"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_6
          expression = SBQLParser.new.scan_str("((emp where married).book.author)")
          self.execute(expression)
          expected = "[Adam Mickiewicz]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_7_sub1
          expression = SBQLParser.new.scan_str("(emp where fName=\"Maciej\")")
          self.execute(expression)
          expected = "[s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_7
          expression = SBQLParser.new.scan_str("((emp where fName=\"Maciej\").address.street)")
          self.execute(expression)
          expected = "[Koszykowa]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_8
          expression = SBQLParser.new.scan_str("((emp.address) where number=50).(street)")
          self.execute(expression)
          expected = "[al. Jerozolimskie]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_9
          expression = SBQLParser.new.scan_str("((emp.address) where zip=\"00-222\").(city)")
          self.execute(expression)
          expected = "[Warszawa]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_10
          expression = SBQLParser.new.scan_str("((emp where married).book.author) union (test)")
          self.execute(expression)
          expected = "bag([Adam Mickiewicz],[TEST])"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_11
          expression = SBQLParser.new.scan_str("((emp where fName=\"Maciej\").address.street)")
          self.execute(expression)
          expected = "[Koszykowa]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_12
          expression = SBQLParser.new.scan_str("((emp.address) where number > 20).(street,city)")
          self.execute(expression)
          expected = "bag(struct([al. Jerozolimskie],[Warszawa]),struct([Koszykowa],[Warszawa]),struct([Mickiewicza],[Kraków]),struct([Słowackiego],[Poznań]))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_13
          expression = SBQLParser.new.scan_str("emp as e join (dept where dept_id=e.dept_id)")
          self.execute(expression)
          expected = "bag(struct(([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]]) as e,[2,Accounting]),struct(([s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false]) as e,[1,IT]),struct(([s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false]) as e,[1,IT]),struct(([s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true]) as e,[2,Accounting]))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_14
          expression = SBQLParser.new.scan_str("(dept as d join (max((emp where dept_id=d.dept_id).salary) as maxSal)).(d.name,maxSal)")
          self.execute(expression)
          expected = ""
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_15
          expression = SBQLParser.new.scan_str("(dept as d join (avg((emp where dept_id=d.dept_id).salary) as avgSal)).(d.name,avgSal)")
          self.execute(expression)
          expected = ""
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_16
          expression = SBQLParser.new.scan_str("emp substract (emp where salary = max(emp.salary) or salary = min(emp.salary))")
          self.execute(expression)
          expected = "bag([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]],[s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false],[s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false],[s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true])"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_17
          expression = SBQLParser.new.scan_str("emp where salary < avg(emp.salary)")
          self.execute(expression)
          expected = "[s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true]"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_18
          expression = SBQLParser.new.scan_str("emp join dept")
          self.execute(expression)
          expected = "bag(struct([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]],[1,IT]),struct([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]],[2,Accounting]),struct([s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false],[1,IT]),struct([s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false],[2,Accounting]),struct([s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false],[1,IT]),struct([s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false],[2,Accounting]),struct([s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true],[1,IT]),struct([s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true],[2,Accounting]))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_19
          expression = SBQLParser.new.scan_str("(emp),(dept)")
          self.execute(expression)
          expected = "bag(struct([s0000,Anna,Kowalska,3800,2,[al. Jerozolimskie,50,00-111,Warszawa],true,[Adam Mickiewicz,Pan Tadeusz]],[s0001,Maciej,Nowak,3500,1,[Koszykowa,86,00-222,Warszawa],false],[s0002,Łukasz,Wiśniewski,3600,1,[Mickiewicza,33,30-001,Kraków],false],[s0003,Marzena,Ignasiewicz,2,2200,[Słowackiego,36,61-301,Poznań],true]),struct([1,IT],[2,Accounting]))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_20
          expression = SBQLParser.new.scan_str("emp.(fName,lName, (salary/avg(emp.salary) * 100.0 as SalaryAvgRel))")
          self.execute(expression)
          expected = ""
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_21
          expression = SBQLParser.new.scan_str("emp.(fName,lName, (salary/min(emp.salary) * 100.0 as SalaryMinRel))")
          self.execute(expression)
          expected = "bag(struct([Anna],[Kowalska],(172.727272727273) as SalaryMinRel),struct([Maciej],[Nowak],(159.090909090909) as SalaryMinRel),struct([Łukasz],[Wiśniewski],(163.636363636364) as SalaryMinRel),struct([Marzena],[Ignasiewicz],(100.0) as SalaryMinRel))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_22
          expression = SBQLParser.new.scan_str("emp.(fName,lName, (salary/max(emp.salary) * 100.0 as SalaryMaxRel))")
          self.execute(expression)
          expected = "bag(struct([Anna],[Kowalska],(100.0) as SalaryMaxRel),struct([Maciej],[Nowak],(92.1052631578947) as SalaryMaxRel),struct([Łukasz],[Wiśniewski],(94.7368421052632) as SalaryMaxRel),struct([Marzena],[Ignasiewicz],(57.8947368421053) as SalaryMaxRel))"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_23
          expression = SBQLParser.new.scan_str("\"Hello\" + \" \" + \"World!\"")
          self.execute(expression)
          expected = "Hello World!"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
        def test_parser_24
          expression = SBQLParser.new.scan_str("\"Hello\" + \" \" + \"World!\" as text")
          self.execute(expression)
          expected = "(Hello World!) as text"
          assert_equal(expected,@result.print(@AST.VAR_STORE))
        end
        
    end
end
