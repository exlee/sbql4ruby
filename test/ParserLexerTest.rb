module ParserLexer

require "test/unit"
require "lib/Common/Logger"
require "lib/Parser/ParserStringExtension"
require "lib/Parser/SBQL.tab"


    class ParserLexerTest < Test::Unit::TestCase
        # Test for basic object flow (initializing object etc. based on 
        # empty expression.
        #
        # Params:
        #
        # Returns:
        #
        # Throws:

        def test_SimpleExpression
            Common::Logger.setLogLevel(Common::VAR_DEBUG)
            assert_equal(3, SBQLParser.new.scan_str("2+(1)"))
        end

        def test_operatorPrecedence
            Common::Logger.setLogLevel(Common::VAR_DEBUG)
            assert_equal(6, SBQLParser.new.scan_str("2*2+2"))
        end

        def test_nameExpression
            Common::Logger.setLogLevel(Common::VAR_DEBUG)
            assert_equal("2+abc", SBQLParser.new.scan_str("2+abc"))
        end
    end
end
