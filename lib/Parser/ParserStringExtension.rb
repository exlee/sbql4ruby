require "lib/Parser/grammar.tab"
# Simple extension to the String class which allows to parse
# entry as an SBQL

String.class_eval do
    # method sbql
    # returns new parser from the string
    def sbql
        return Parser.new(self)
    end
    # method sbql_parser
    # returns parser result
    def sbql_parser
        p = Parser.new
        p.do_parse()
    end
end
