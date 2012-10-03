require "lib/AST/AbstractMethodException"
require "lib/AST/AllExpression"
require "lib/AST/AndExpression"
require "lib/AST/AnyExpression"
require "lib/AST/AsExpression"
require "lib/AST/BagExpression"
require "lib/AST/BinaryExpression"
require "lib/AST/BooleanTerminal"
require "lib/AST/CommaExpression"
require "lib/AST/DifferentExpression"
require "lib/AST/DivideExpression"
require "lib/AST/DotExpression"
require "lib/AST/EqualExpression"
require "lib/AST/Expression"
require "lib/AST/FloatTerminal"
require "lib/AST/GreatherEqualExpression"
require "lib/AST/GreatherExpression"
require "lib/AST/GroupAsExpression"
require "lib/AST/IncorrectArgumentException"
require "lib/AST/IntegerTerminal"
require "lib/AST/IntersectExpression"
require "lib/AST/LessEqualExpression"
require "lib/AST/LessExpression"
require "lib/AST/MinusExpression"
require "lib/AST/ModuloExpression"
require "lib/AST/MultiplyExpression"
require "lib/AST/NameExpression"
require "lib/AST/OrExpression"
require "lib/AST/PlusExpression"
require "lib/AST/StringTerminal"
require "lib/AST/StructExpression"
require "lib/AST/TerminalExpression"
require "lib/AST/UnaryExpression"
require "lib/AST/UnionExpression"
require "lib/AST/UniqueExpression"
require "lib/AST/Utils"
require "lib/AST/WhereExpression"

include AST

class SBQLParser
option
    ignorecase
macro
 	PLUS			 \+
 	MINUS	 -
 	MULTIPLY			 \*
 	MODULO 			 %
 	DIVIDE				 \/
 	LEFT_ROUND_BRACKET  \(
 	RIGHT_ROUND_BRACKET \)
     COMMA ,
     DIFFERENCE !=
     DOT \.
     EQUAL =
     EQUAL ==
     GREATEREQUAL >=
     GREATER >
     JOIN join
     ORDERBY order_by
     AVG avg
     SMALLEREQUAL <=
     SMALLER <
     UNION union
     UNIQUE unique
     INTERSECT intersect
     WHERE where
     ANY any
     ALL all
     BAG bag
     EXISTS exists
     GROUPAS groupas
     GROUPAS group as
     MAX max
     MIN min
     NOT not
     PICKRANDOM pickrandom
     STRUCT struct
     SUM sum
     AS as
     AND and
     OR or
    BOOLEAN         true|false
    NAME            [_a-zA-Z][0-9a-zA-Z]*
    DOUBLE          [0-9]+\.[0-9]+
    INTEGER         [0-9]+
    STRING          [\"][^\"]*[\"]
    CHAR            [\'][^\"][\']
    LineTerminator  \r|\n|\r\n 
    WHITESPACE      \s+
rule
    {WHITESPACE}
    {LineTerminator}
    {BOOLEAN}	    { [:BOOLEAN_LITERAL, BooleanTerminal.new(text.downcase == "true")] }
    {DOUBLE}	    { [:DOUBLE_LITERAL, FloatTerminal.new(text.to_f)] }
    {INTEGER}	    { [:INTEGER_LITERAL, IntegerTerminal.new(text.to_i)] }
    {STRING}	    { [:STRING_LITERAL, StringTerminal.new(text)] }
    {CHAR}	        { [:CHAR_LITERAL, text] }
	{PLUS}			{ [:PLUS,nil] }
	{MINUS}			{ [:MINUS,nil] }
	{MULTIPLY}		{ [:MULTIPLY,nil] }
	{MODULO}		{ [:MODULO,nil] }
	{DIVIDE}		{ [:DIVIDE,nil] }
	{LEFT_ROUND_BRACKET}			{ [:LEFT_ROUND_BRACKET,nil] }
	{RIGHT_ROUND_BRACKET}			{ [:RIGHT_ROUND_BRACKET,nil] }
	{COMMA}			{ [:COMMA,nil] }
	{DIFFERENCE}	{ [:DIFFERENCE,nil] }
	{DOT}			{ [:DOT,nil] }
	{EQUAL}			{ [:EQUAL,nil] }
	{EQUAL}			{ [:EQUAL,nil] }
	{GREATEREQUAL}	{ [:GREATEREQUAL,nil] }
	{GREATER}		{ [:GREATER,nil] }
	{JOIN}			{ [:JOIN,nil] }
	{ORDERBY}		{ [:ORDERBY,nil] }
	{AVG}       { [:AVG, nil] }
	{SMALLEREQUAL}	{ [:SMALLEREQUAL,nil] }
	{SMALLER}		{ [:SMALLER,nil] }
	{UNION}			{ [:UNION,nil] }
	{UNIQUE}		{ [:UNIQUE,nil] }
	{INTERSECT}		{ [:INTERSECT,nil] }
	{WHERE}			{ [:WHERE,nil] }
	{ANY}			{ [:ANY,nil] }
	{ALL}			{ [:ALL,nil] }
	{BAG}			{ [:BAG,nil] }
	{EXISTS}		{ [:EXISTS,nil] }
	{GROUPAS}		{ [:GROUPAS,nil] }
	{GROUPAS}		{ [:GROUPAS,nil] }
	{MAX}			{ [:MAX,nil] }
	{MIN}			{ [:MIN,nil] }
	{NOT}			{ [:NOT,nil] }
	{PICKRANDOM}	{ [:PICKRANDOM,nil] }
	{STRUCT}		{ [:STRUCT,nil] }
	{SUM}			{ [:SUM,nil] }
	{AS}			{ [:AS,nil] }
	{AND}			{ [:AND,nil] }
	{OR}			{ [:OR,nil] }
    {NAME}          { [:NAME, text] }
    .               { [text, text] }
end
