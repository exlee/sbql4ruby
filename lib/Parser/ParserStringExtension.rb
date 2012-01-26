require "lib/Parser/grammar.tab"
String.class_eval do
    def sbql
        return Parser.new(self)
    end
    def sbql_parser
        p = Parser.new
        p.do_parse()
    end
end
