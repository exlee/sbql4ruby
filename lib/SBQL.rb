require "rubygems"
require "ruby-debug"

Dir["lib/QRES/*.rb"].each {|file| require file }
Dir["lib/Operator/*.rb"].each {|file| require file }
Dir["lib/AST/*.rb"].each {|file| require file }
require "lib/Parser/ParserStringExtension"


class SBQL
  @@initialized = false

  def SBQL.init(xml_file)
    @@initialized = true
    @@data = xml_file
  end
  
  def SBQL.cleanup
    SBAStore::SBAObject.reset_counter
    @AST = AST::AST.new(@@data)
  end
  
  def SBQL.query(str)
    SBQL.cleanup
    raise "SBQL not initialized, init with SBQL.init(data_file)" unless @@initialized
    expression = SBQLParser.new.scan_str(str)
    expression.execute(@AST)
    @result = @AST.VAR_QRES().pop()
    return @result.print(@AST.VAR_STORE)
  end
  
  def SBQL.raw(str)
    SBQL.cleanup
    raise "SBQL not initialized, init with SBQL.init(data_file)" unless @@initialized
    expression = SBQLParser.new.scan_str(str)
    expression.execute(@AST)
    @result = @AST.VAR_QRES().pop()
    return @result
  end
end