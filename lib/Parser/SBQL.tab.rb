#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.7
# from Racc grammer file "".
#

require 'racc/parser.rb'

#
# generated by racc
#
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

require 'lib/Parser/SBQL.rex'

include AST
class SBQLParser < Racc::Parser
##### State transition tables begin ###

racc_action_table = [
    30,    32,    10,    36,    39,    41,    17,    19,    46,     2,
     4,     7,     8,     9,    12,    38,    42,    44,    45,    47,
    26,    27,    28,    31,    34,    35,    37,    40,    43,    20,
    23,     1,     5,    29,    33,    11,    13,    14,    15,    16,
    18,    30,    32,    10,    36,    39,    41,    17,    19,    46,
     2,     4,     7,     8,     9,    12,    38,    42,    44,    45,
    47,    26,    27,    28,    31,    34,    35,    37,    40,    43,
    20,    69,     1,     5,    29,    33,    11,    13,    14,    15,
    16,    18,    10,    30,    32,    77,    17,    19,    30,     2,
     4,     7,     8,     9,    12,    10,    30,    32,    56,    17,
    19,   nil,     2,     4,     7,     8,     9,    12,   nil,    20,
   nil,     1,     5,    30,    32,    11,    13,    14,    15,    16,
    18,   nil,    20,   nil,     1,     5,    30,    32,    11,    13,
    14,    15,    16,    18,    10,    30,    32,   nil,    17,    19,
   nil,     2,     4,     7,     8,     9,    12,    10,    30,    32,
   nil,    17,    19,   nil,     2,     4,     7,     8,     9,    12,
   nil,    20,   nil,     1,     5,    30,    32,    11,    13,    14,
    15,    16,    18,   nil,    20,   nil,     1,     5,    30,    32,
    11,    13,    14,    15,    16,    18,    10,    30,    32,   nil,
    17,    19,   nil,     2,     4,     7,     8,     9,    12,    10,
    30,    32,   nil,    17,    19,   nil,     2,     4,     7,     8,
     9,    12,   nil,    20,   nil,     1,     5,    30,    32,    11,
    13,    14,    15,    16,    18,   nil,    20,   nil,     1,     5,
    30,    32,    11,    13,    14,    15,    16,    18,    10,   nil,
   nil,   nil,    17,    19,   nil,     2,     4,     7,     8,     9,
    12,    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,
     7,     8,     9,    12,   nil,    20,   nil,     1,     5,   nil,
   nil,    11,    13,    14,    15,    16,    18,   nil,    20,   nil,
     1,     5,   nil,   nil,    11,    13,    14,    15,    16,    18,
    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,     7,
     8,     9,    12,    10,   nil,   nil,   nil,    17,    19,   nil,
     2,     4,     7,     8,     9,    12,   nil,    20,   nil,     1,
     5,   nil,   nil,    11,    13,    14,    15,    16,    18,   nil,
    20,   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,
    16,    18,    10,   nil,   nil,   nil,    17,    19,   nil,     2,
     4,     7,     8,     9,    12,    10,   nil,   nil,   nil,    17,
    19,   nil,     2,     4,     7,     8,     9,    12,   nil,    20,
   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,    16,
    18,   nil,    20,   nil,     1,     5,   nil,   nil,    11,    13,
    14,    15,    16,    18,    10,   nil,   nil,   nil,    17,    19,
   nil,     2,     4,     7,     8,     9,    12,    10,   nil,   nil,
   nil,    17,    19,   nil,     2,     4,     7,     8,     9,    12,
   nil,    20,   nil,     1,     5,   nil,   nil,    11,    13,    14,
    15,    16,    18,   nil,    20,   nil,     1,     5,   nil,   nil,
    11,    13,    14,    15,    16,    18,    10,   nil,   nil,   nil,
    17,    19,   nil,     2,     4,     7,     8,     9,    12,    10,
   nil,   nil,   nil,    17,    19,   nil,     2,     4,     7,     8,
     9,    12,   nil,    20,   nil,     1,     5,   nil,   nil,    11,
    13,    14,    15,    16,    18,   nil,    20,   nil,     1,     5,
   nil,   nil,    11,    13,    14,    15,    16,    18,    10,   nil,
   nil,   nil,    17,    19,   nil,     2,     4,     7,     8,     9,
    12,    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,
     7,     8,     9,    12,   nil,    20,   nil,     1,     5,   nil,
   nil,    11,    13,    14,    15,    16,    18,   nil,    20,   nil,
     1,     5,   nil,   nil,    11,    13,    14,    15,    16,    18,
    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,     7,
     8,     9,    12,    10,   nil,   nil,   nil,    17,    19,   nil,
     2,     4,     7,     8,     9,    12,   nil,    20,   nil,     1,
     5,   nil,   nil,    11,    13,    14,    15,    16,    18,   nil,
    20,   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,
    16,    18,    10,   nil,   nil,   nil,    17,    19,   nil,     2,
     4,     7,     8,     9,    12,    10,   nil,   nil,   nil,    17,
    19,   nil,     2,     4,     7,     8,     9,    12,   nil,    20,
   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,    16,
    18,   nil,    20,   nil,     1,     5,   nil,   nil,    11,    13,
    14,    15,    16,    18,    10,   nil,   nil,   nil,    17,    19,
   nil,     2,     4,     7,     8,     9,    12,    10,   nil,   nil,
   nil,    17,    19,   nil,     2,     4,     7,     8,     9,    12,
   nil,    20,   nil,     1,     5,   nil,   nil,    11,    13,    14,
    15,    16,    18,   nil,    20,   nil,     1,     5,   nil,   nil,
    11,    13,    14,    15,    16,    18,    10,   nil,   nil,   nil,
    17,    19,   nil,     2,     4,     7,     8,     9,    12,    10,
   nil,   nil,   nil,    17,    19,   nil,     2,     4,     7,     8,
     9,    12,   nil,    20,   nil,     1,     5,   nil,   nil,    11,
    13,    14,    15,    16,    18,   nil,    20,   nil,     1,     5,
   nil,   nil,    11,    13,    14,    15,    16,    18,    10,   nil,
   nil,   nil,    17,    19,   nil,     2,     4,     7,     8,     9,
    12,    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,
     7,     8,     9,    12,   nil,    20,   nil,     1,     5,   nil,
   nil,    11,    13,    14,    15,    16,    18,   nil,    20,   nil,
     1,     5,   nil,   nil,    11,    13,    14,    15,    16,    18,
    10,   nil,   nil,   nil,    17,    19,   nil,     2,     4,     7,
     8,     9,    12,    10,   nil,   nil,   nil,    17,    19,   nil,
     2,     4,     7,     8,     9,    12,   nil,    20,   nil,     1,
     5,   nil,   nil,    11,    13,    14,    15,    16,    18,   nil,
    20,   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,
    16,    18,    10,   nil,   nil,   nil,    17,    19,   nil,     2,
     4,     7,     8,     9,    12,    10,   nil,   nil,   nil,    17,
    19,   nil,     2,     4,     7,     8,     9,    12,   nil,    20,
   nil,     1,     5,   nil,   nil,    11,    13,    14,    15,    16,
    18,   nil,    20,   nil,     1,     5,   nil,   nil,    11,    13,
    14,    15,    16,    18,    10,   nil,   nil,   nil,    17,    19,
   nil,     2,     4,     7,     8,     9,    12,   nil,   nil,   nil,
    30,    32,   nil,    36,    39,    41,   nil,   nil,    46,   nil,
   nil,    20,   nil,     1,     5,    38,    42,    11,    13,    14,
    15,    16,    18,    30,    32,   nil,    36,    39,    41,   nil,
   nil,    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,    42,
    44,    45,    47,    26,    27,    28,    31,    34,    35,    37,
    40,    43,   nil,   nil,   nil,   nil,    29,    33,    30,    32,
   nil,    36,    39,    41,   nil,   nil,    46,   nil,   nil,   nil,
   nil,   nil,   nil,    38,    42,    44,    45,    47,    26,    27,
    28,    31,    34,    35,    37,    40,    43,   nil,   nil,   nil,
   nil,    29,    33,    30,    32,   nil,    36,    39,    41,   nil,
   nil,    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,    42,
    44,    45,    47,    26,    27,    28,    31,    34,    35,    37,
    40,    43,   nil,    81,   nil,   nil,    29,    33,    30,    32,
   nil,    36,    39,    41,   nil,   nil,    46,   nil,   nil,   nil,
   nil,   nil,   nil,    38,    42,    44,    45,    47,    26,    27,
    28,    31,    34,    35,    37,    40,    43,   nil,   nil,    30,
    32,    29,    36,    39,    41,   nil,   nil,    46,   nil,   nil,
   nil,   nil,   nil,   nil,    38,    42,    44,    45,    47,    26,
    27,    28,    31,    34,    35,    37,    40,    43,    30,    32,
   nil,    36,    39,    41,   nil,   nil,    46,   nil,   nil,   nil,
   nil,   nil,   nil,    38,    42,    44,    45,    47,    26,    27,
    28,    31,    34,    35,    37,    40,    43,    30,    32,   nil,
    36,    39,    41,   nil,   nil,    46,   nil,   nil,   nil,   nil,
   nil,   nil,    38,    42,    44,    45,    47,    26,    27,    28,
    31,    34,    35,    37,    40,    43,    30,    32,   nil,    36,
    39,    41,   nil,   nil,    46,   nil,   nil,   nil,   nil,   nil,
   nil,    38,    42,    44,    45,    47,    26,    27,    28,    31,
    34,    35,    37,    30,    32,   nil,    36,    39,    41,   nil,
   nil,    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,    42,
    44,    45,    47,    26,    27,    28,    31,    34,    35,    37,
    30,    32,   nil,    36,    39,    41,   nil,   nil,    46,   nil,
   nil,   nil,   nil,   nil,   nil,    38,    42,    44,    45,    47,
    26,    27,    28,    31,    30,    32,   nil,    36,    39,    41,
   nil,   nil,    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,
    42,    44,    45,    47,    26,    27,    28,    31,    30,    32,
   nil,    36,    39,    41,   nil,   nil,    46,   nil,   nil,   nil,
   nil,   nil,   nil,    38,    42,    44,    45,    47,    26,    27,
    28,    31,    30,    32,   nil,    36,    39,    41,   nil,   nil,
    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,    42,    44,
    45,    47,    26,    27,    30,    32,   nil,    36,    39,    41,
   nil,   nil,    46,   nil,   nil,   nil,   nil,   nil,   nil,    38,
    42,    44,    45,    47,    26,    27,    30,    32,   nil,    36,
    39,    41,    30,    32,    46,    36,    39,    41,   nil,   nil,
    46,    38,    42,   nil,   nil,   nil,   nil,    38,    42,    30,
    32,   nil,    36,    39,    41,    30,    32,    46,    36,    39,
    41,   nil,   nil,    46,    38,    42,   nil,   nil,   nil,   nil,
    38,    42 ]

racc_action_check = [
    53,    53,    53,    53,    53,    53,    53,    53,    53,    53,
    53,    53,    53,    53,    53,    53,    53,    53,    53,    53,
    53,    53,    53,    53,    53,    53,    53,    53,    53,    53,
     3,    53,    53,    53,    53,    53,    53,    53,    53,    53,
    53,    50,    50,    50,    50,    50,    50,    50,    50,    50,
    50,    50,    50,    50,    50,    50,    50,    50,    50,    50,
    50,    50,    50,    50,    50,    50,    50,    50,    50,    50,
    50,    38,    50,    50,    50,    50,    50,    50,    50,    50,
    50,    50,    30,    54,    54,    46,    30,    30,    63,    30,
    30,    30,    30,    30,    30,     0,    79,    79,    23,     0,
     0,   nil,     0,     0,     0,     0,     0,     0,   nil,    30,
   nil,    30,    30,    49,    49,    30,    30,    30,    30,    30,
    30,   nil,     0,   nil,     0,     0,    48,    48,     0,     0,
     0,     0,     0,     0,     4,    24,    24,   nil,     4,     4,
   nil,     4,     4,     4,     4,     4,     4,     5,    67,    67,
   nil,     5,     5,   nil,     5,     5,     5,     5,     5,     5,
   nil,     4,   nil,     4,     4,    51,    51,     4,     4,     4,
     4,     4,     4,   nil,     5,   nil,     5,     5,    70,    70,
     5,     5,     5,     5,     5,     5,     1,    22,    22,   nil,
     1,     1,   nil,     1,     1,     1,     1,     1,     1,     8,
    72,    72,   nil,     8,     8,   nil,     8,     8,     8,     8,
     8,     8,   nil,     1,   nil,     1,     1,    73,    73,     1,
     1,     1,     1,     1,     1,   nil,     8,   nil,     8,     8,
    80,    80,     8,     8,     8,     8,     8,     8,     9,   nil,
   nil,   nil,     9,     9,   nil,     9,     9,     9,     9,     9,
     9,    10,   nil,   nil,   nil,    10,    10,   nil,    10,    10,
    10,    10,    10,    10,   nil,     9,   nil,     9,     9,   nil,
   nil,     9,     9,     9,     9,     9,     9,   nil,    10,   nil,
    10,    10,   nil,   nil,    10,    10,    10,    10,    10,    10,
    12,   nil,   nil,   nil,    12,    12,   nil,    12,    12,    12,
    12,    12,    12,    13,   nil,   nil,   nil,    13,    13,   nil,
    13,    13,    13,    13,    13,    13,   nil,    12,   nil,    12,
    12,   nil,   nil,    12,    12,    12,    12,    12,    12,   nil,
    13,   nil,    13,    13,   nil,   nil,    13,    13,    13,    13,
    13,    13,    17,   nil,   nil,   nil,    17,    17,   nil,    17,
    17,    17,    17,    17,    17,    19,   nil,   nil,   nil,    19,
    19,   nil,    19,    19,    19,    19,    19,    19,   nil,    17,
   nil,    17,    17,   nil,   nil,    17,    17,    17,    17,    17,
    17,   nil,    19,   nil,    19,    19,   nil,   nil,    19,    19,
    19,    19,    19,    19,    20,   nil,   nil,   nil,    20,    20,
   nil,    20,    20,    20,    20,    20,    20,    47,   nil,   nil,
   nil,    47,    47,   nil,    47,    47,    47,    47,    47,    47,
   nil,    20,   nil,    20,    20,   nil,   nil,    20,    20,    20,
    20,    20,    20,   nil,    47,   nil,    47,    47,   nil,   nil,
    47,    47,    47,    47,    47,    47,    45,   nil,   nil,   nil,
    45,    45,   nil,    45,    45,    45,    45,    45,    45,    44,
   nil,   nil,   nil,    44,    44,   nil,    44,    44,    44,    44,
    44,    44,   nil,    45,   nil,    45,    45,   nil,   nil,    45,
    45,    45,    45,    45,    45,   nil,    44,   nil,    44,    44,
   nil,   nil,    44,    44,    44,    44,    44,    44,    43,   nil,
   nil,   nil,    43,    43,   nil,    43,    43,    43,    43,    43,
    43,    42,   nil,   nil,   nil,    42,    42,   nil,    42,    42,
    42,    42,    42,    42,   nil,    43,   nil,    43,    43,   nil,
   nil,    43,    43,    43,    43,    43,    43,   nil,    42,   nil,
    42,    42,   nil,   nil,    42,    42,    42,    42,    42,    42,
    26,   nil,   nil,   nil,    26,    26,   nil,    26,    26,    26,
    26,    26,    26,    27,   nil,   nil,   nil,    27,    27,   nil,
    27,    27,    27,    27,    27,    27,   nil,    26,   nil,    26,
    26,   nil,   nil,    26,    26,    26,    26,    26,    26,   nil,
    27,   nil,    27,    27,   nil,   nil,    27,    27,    27,    27,
    27,    27,    28,   nil,   nil,   nil,    28,    28,   nil,    28,
    28,    28,    28,    28,    28,    29,   nil,   nil,   nil,    29,
    29,   nil,    29,    29,    29,    29,    29,    29,   nil,    28,
   nil,    28,    28,   nil,   nil,    28,    28,    28,    28,    28,
    28,   nil,    29,   nil,    29,    29,   nil,   nil,    29,    29,
    29,    29,    29,    29,     2,   nil,   nil,   nil,     2,     2,
   nil,     2,     2,     2,     2,     2,     2,    40,   nil,   nil,
   nil,    40,    40,   nil,    40,    40,    40,    40,    40,    40,
   nil,     2,   nil,     2,     2,   nil,   nil,     2,     2,     2,
     2,     2,     2,   nil,    40,   nil,    40,    40,   nil,   nil,
    40,    40,    40,    40,    40,    40,    32,   nil,   nil,   nil,
    32,    32,   nil,    32,    32,    32,    32,    32,    32,    33,
   nil,   nil,   nil,    33,    33,   nil,    33,    33,    33,    33,
    33,    33,   nil,    32,   nil,    32,    32,   nil,   nil,    32,
    32,    32,    32,    32,    32,   nil,    33,   nil,    33,    33,
   nil,   nil,    33,    33,    33,    33,    33,    33,    34,   nil,
   nil,   nil,    34,    34,   nil,    34,    34,    34,    34,    34,
    34,    35,   nil,   nil,   nil,    35,    35,   nil,    35,    35,
    35,    35,    35,    35,   nil,    34,   nil,    34,    34,   nil,
   nil,    34,    34,    34,    34,    34,    34,   nil,    35,   nil,
    35,    35,   nil,   nil,    35,    35,    35,    35,    35,    35,
    36,   nil,   nil,   nil,    36,    36,   nil,    36,    36,    36,
    36,    36,    36,    37,   nil,   nil,   nil,    37,    37,   nil,
    37,    37,    37,    37,    37,    37,   nil,    36,   nil,    36,
    36,   nil,   nil,    36,    36,    36,    36,    36,    36,   nil,
    37,   nil,    37,    37,   nil,   nil,    37,    37,    37,    37,
    37,    37,    41,   nil,   nil,   nil,    41,    41,   nil,    41,
    41,    41,    41,    41,    41,    39,   nil,   nil,   nil,    39,
    39,   nil,    39,    39,    39,    39,    39,    39,   nil,    41,
   nil,    41,    41,   nil,   nil,    41,    41,    41,    41,    41,
    41,   nil,    39,   nil,    39,    39,   nil,   nil,    39,    39,
    39,    39,    39,    39,    31,   nil,   nil,   nil,    31,    31,
   nil,    31,    31,    31,    31,    31,    31,   nil,   nil,   nil,
    76,    76,   nil,    76,    76,    76,   nil,   nil,    76,   nil,
   nil,    31,   nil,    31,    31,    76,    76,    31,    31,    31,
    31,    31,    31,     6,     6,   nil,     6,     6,     6,   nil,
   nil,     6,   nil,   nil,   nil,   nil,   nil,   nil,     6,     6,
     6,     6,     6,     6,     6,     6,     6,     6,     6,     6,
     6,     6,   nil,   nil,   nil,   nil,     6,     6,    52,    52,
   nil,    52,    52,    52,   nil,   nil,    52,   nil,   nil,   nil,
   nil,   nil,   nil,    52,    52,    52,    52,    52,    52,    52,
    52,    52,    52,    52,    52,    52,    52,   nil,   nil,   nil,
   nil,    52,    52,    55,    55,   nil,    55,    55,    55,   nil,
   nil,    55,   nil,   nil,   nil,   nil,   nil,   nil,    55,    55,
    55,    55,    55,    55,    55,    55,    55,    55,    55,    55,
    55,    55,   nil,    55,   nil,   nil,    55,    55,    64,    64,
   nil,    64,    64,    64,   nil,   nil,    64,   nil,   nil,   nil,
   nil,   nil,   nil,    64,    64,    64,    64,    64,    64,    64,
    64,    64,    64,    64,    64,    64,    64,   nil,   nil,    60,
    60,    64,    60,    60,    60,   nil,   nil,    60,   nil,   nil,
   nil,   nil,   nil,   nil,    60,    60,    60,    60,    60,    60,
    60,    60,    60,    60,    60,    60,    60,    60,    25,    25,
   nil,    25,    25,    25,   nil,   nil,    25,   nil,   nil,   nil,
   nil,   nil,   nil,    25,    25,    25,    25,    25,    25,    25,
    25,    25,    25,    25,    25,    25,    25,    21,    21,   nil,
    21,    21,    21,   nil,   nil,    21,   nil,   nil,   nil,   nil,
   nil,   nil,    21,    21,    21,    21,    21,    21,    21,    21,
    21,    21,    21,    21,    21,    21,    71,    71,   nil,    71,
    71,    71,   nil,   nil,    71,   nil,   nil,   nil,   nil,   nil,
   nil,    71,    71,    71,    71,    71,    71,    71,    71,    71,
    71,    71,    71,    74,    74,   nil,    74,    74,    74,   nil,
   nil,    74,   nil,   nil,   nil,   nil,   nil,   nil,    74,    74,
    74,    74,    74,    74,    74,    74,    74,    74,    74,    74,
    65,    65,   nil,    65,    65,    65,   nil,   nil,    65,   nil,
   nil,   nil,   nil,   nil,   nil,    65,    65,    65,    65,    65,
    65,    65,    65,    65,    68,    68,   nil,    68,    68,    68,
   nil,   nil,    68,   nil,   nil,   nil,   nil,   nil,   nil,    68,
    68,    68,    68,    68,    68,    68,    68,    68,    66,    66,
   nil,    66,    66,    66,   nil,   nil,    66,   nil,   nil,   nil,
   nil,   nil,   nil,    66,    66,    66,    66,    66,    66,    66,
    66,    66,    62,    62,   nil,    62,    62,    62,   nil,   nil,
    62,   nil,   nil,   nil,   nil,   nil,   nil,    62,    62,    62,
    62,    62,    62,    62,    59,    59,   nil,    59,    59,    59,
   nil,   nil,    59,   nil,   nil,   nil,   nil,   nil,   nil,    59,
    59,    59,    59,    59,    59,    59,    57,    57,   nil,    57,
    57,    57,    58,    58,    57,    58,    58,    58,   nil,   nil,
    58,    57,    57,   nil,   nil,   nil,   nil,    58,    58,    75,
    75,   nil,    75,    75,    75,    78,    78,    75,    78,    78,
    78,   nil,   nil,    78,    75,    75,   nil,   nil,   nil,   nil,
    78,    78 ]

racc_action_pointer = [
    91,   182,   650,    30,   130,   143,   951,   nil,   195,   234,
   247,   nil,   286,   299,   nil,   nil,   nil,   338,   nil,   351,
   390,  1145,   185,    98,   133,  1116,   546,   559,   598,   611,
    78,   910,   702,   715,   754,   767,   806,   819,    58,   871,
   663,   858,   507,   494,   455,   442,    72,   403,   124,   111,
    39,   163,   986,    -2,    81,  1021,   nil,  1344,  1350,  1322,
  1087,   nil,  1300,    86,  1056,  1228,  1276,   146,  1252,   nil,
   176,  1174,   198,   215,  1201,  1367,   928,   nil,  1373,    94,
   228,   nil ]

racc_action_default = [
   -42,   -42,   -42,   -42,   -42,   -42,    -1,   -30,   -42,   -42,
   -42,    -3,   -42,   -42,   -26,   -27,   -28,   -42,   -29,   -42,
   -42,   -34,   -21,   -42,   -22,   -19,   -42,   -42,   -42,   -42,
   -42,   -42,   -42,   -42,   -42,   -42,   -42,   -42,   -42,   -42,
   -42,   -42,   -42,   -42,   -42,   -42,   -42,   -42,   -31,   -33,
   -42,   -32,   -23,   -42,   -20,   -42,    82,   -14,   -15,   -40,
    -8,    -2,   -41,   -18,   -13,   -37,   -39,   -12,   -38,   -24,
   -16,   -35,   -17,    -7,   -36,    -9,   -10,   -25,   -11,    -5,
    -6,    -4 ]

racc_goto_table = [
     6,    21,    22,     3,    24,    25,   nil,   nil,    48,    49,
    50,   nil,    51,    52,   nil,   nil,   nil,    53,   nil,    54,
    55,   nil,   nil,   nil,   nil,   nil,    57,    58,    59,    60,
    61,    62,    63,    64,    65,    66,    67,    68,   nil,    70,
    71,    72,    73,    74,    75,    76,   nil,    78,   nil,   nil,
    79,   nil,   nil,    80 ]

racc_goto_check = [
     2,     2,     2,     1,     2,     2,   nil,   nil,     2,     2,
     2,   nil,     2,     2,   nil,   nil,   nil,     2,   nil,     2,
     2,   nil,   nil,   nil,   nil,   nil,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,   nil,     2,
     2,     2,     2,     2,     2,     2,   nil,     2,   nil,   nil,
     2,   nil,   nil,     2 ]

racc_goto_pointer = [
   nil,     3,     0 ]

racc_goto_default = [
   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 44, :_reduce_none,
  3, 45, :_reduce_2,
  1, 45, :_reduce_3,
  3, 45, :_reduce_4,
  3, 45, :_reduce_5,
  3, 45, :_reduce_6,
  3, 45, :_reduce_7,
  3, 45, :_reduce_8,
  3, 45, :_reduce_9,
  3, 45, :_reduce_10,
  3, 45, :_reduce_11,
  3, 45, :_reduce_12,
  3, 45, :_reduce_13,
  3, 45, :_reduce_14,
  3, 45, :_reduce_15,
  3, 45, :_reduce_16,
  3, 45, :_reduce_17,
  3, 45, :_reduce_18,
  2, 45, :_reduce_19,
  2, 45, :_reduce_20,
  2, 45, :_reduce_21,
  2, 45, :_reduce_22,
  2, 45, :_reduce_23,
  3, 45, :_reduce_24,
  3, 45, :_reduce_25,
  1, 45, :_reduce_26,
  1, 45, :_reduce_27,
  1, 45, :_reduce_28,
  1, 45, :_reduce_29,
  1, 45, :_reduce_30,
  2, 45, :_reduce_31,
  2, 45, :_reduce_32,
  2, 45, :_reduce_33,
  2, 45, :_reduce_34,
  3, 45, :_reduce_35,
  3, 45, :_reduce_36,
  3, 45, :_reduce_37,
  3, 45, :_reduce_38,
  3, 45, :_reduce_39,
  3, 45, :_reduce_40,
  3, 45, :_reduce_41 ]

racc_reduce_n = 42

racc_shift_n = 82

racc_token_table = {
  false => 0,
  :error => 1,
  :COMMA => 2,
  :WHERE => 3,
  :ANY => 4,
  :JOIN => 5,
  :UNION => 6,
  :INTERSECT => 7,
  :ALL => 8,
  :EXISTS => 9,
  :GROUPAS => 10,
  :MAX => 11,
  :MIN => 12,
  :NAME => 13,
  :NOT => 14,
  :PICKRANDOM => 15,
  :SUM => 16,
  :AS => 17,
  :DIFFERENCE => 18,
  :EQUAL => 19,
  :GREATEREQUAL => 20,
  :GREATER => 21,
  :SMALLEREQUAL => 22,
  :SMALLER => 23,
  :AND => 24,
  :OR => 25,
  :MULTIPLY => 26,
  :DIVIDE => 27,
  :MODULO => 28,
  :PLUS => 29,
  :MINUS => 30,
  :LEFT_ROUND_BRACKET => 31,
  :RIGHT_ROUND_BRACKET => 32,
  :STRUCT => 33,
  :BAG => 34,
  :DOT => 35,
  :ORDERBY => 36,
  :expr_without_coma => 37,
  :UNIQUE => 38,
  :INTEGER_LITERAL => 39,
  :DOUBLE_LITERAL => 40,
  :STRING_LITERAL => 41,
  :BOOLEAN_LITERAL => 42 }

racc_nt_base = 43

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "COMMA",
  "WHERE",
  "ANY",
  "JOIN",
  "UNION",
  "INTERSECT",
  "ALL",
  "EXISTS",
  "GROUPAS",
  "MAX",
  "MIN",
  "NAME",
  "NOT",
  "PICKRANDOM",
  "SUM",
  "AS",
  "DIFFERENCE",
  "EQUAL",
  "GREATEREQUAL",
  "GREATER",
  "SMALLEREQUAL",
  "SMALLER",
  "AND",
  "OR",
  "MULTIPLY",
  "DIVIDE",
  "MODULO",
  "PLUS",
  "MINUS",
  "LEFT_ROUND_BRACKET",
  "RIGHT_ROUND_BRACKET",
  "STRUCT",
  "BAG",
  "DOT",
  "ORDERBY",
  "expr_without_coma",
  "UNIQUE",
  "INTEGER_LITERAL",
  "DOUBLE_LITERAL",
  "STRING_LITERAL",
  "BOOLEAN_LITERAL",
  "$start",
  "target",
  "expr" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

module_eval(<<'.,.,', 'SBQL.racc', 20)
  def _reduce_2(val, _values, result)
     result = new CommaExpression(e1,e2) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 21)
  def _reduce_3(val, _values, result)
     result = e 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 22)
  def _reduce_4(val, _values, result)
     result = val[1] 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 23)
  def _reduce_5(val, _values, result)
     result = new AnyExpression(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 24)
  def _reduce_6(val, _values, result)
     result = AllExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 25)
  def _reduce_7(val, _values, result)
     result = DifferentExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 26)
  def _reduce_8(val, _values, result)
     result = DotExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 27)
  def _reduce_9(val, _values, result)
     result = EqualExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 28)
  def _reduce_10(val, _values, result)
     result = GreaterEqualExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 29)
  def _reduce_11(val, _values, result)
     result = GreaterExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 30)
  def _reduce_12(val, _values, result)
     result = JoinExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 31)
  def _reduce_13(val, _values, result)
     result = OrderByExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 32)
  def _reduce_14(val, _values, result)
     result = SmallerEqualExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 33)
  def _reduce_15(val, _values, result)
     result = SmallerExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 34)
  def _reduce_16(val, _values, result)
     result = UnionExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 35)
  def _reduce_17(val, _values, result)
     result = IntersectExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 36)
  def _reduce_18(val, _values, result)
     result = WhereExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 37)
  def _reduce_19(val, _values, result)
     result = BagExpression.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 38)
  def _reduce_20(val, _values, result)
     result = ExistsExpression.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 39)
  def _reduce_21(val, _values, result)
     result = MaxExpression.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 40)
  def _reduce_22(val, _values, result)
     result = MinExpression.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 41)
  def _reduce_23(val, _values, result)
     result = new UniqueExpression(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 42)
  def _reduce_24(val, _values, result)
     result = new AsExpression(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 43)
  def _reduce_25(val, _values, result)
     result = new GroupAsExpression(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 44)
  def _reduce_26(val, _values, result)
     result = (val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 45)
  def _reduce_27(val, _values, result)
     result = (val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 46)
  def _reduce_28(val, _values, result)
     result = (val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 47)
  def _reduce_29(val, _values, result)
     result = (val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 48)
  def _reduce_30(val, _values, result)
     result = NameExpression.new(val[0])
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 49)
  def _reduce_31(val, _values, result)
     result = NotExpression.new(val[1])  
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 50)
  def _reduce_32(val, _values, result)
     result = SumExpression.new(val[1])  
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 51)
  def _reduce_33(val, _values, result)
     result = PickRandomExpression.new(val[1])  
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 52)
  def _reduce_34(val, _values, result)
     result = StructExpression.new(val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 53)
  def _reduce_35(val, _values, result)
     result = PlusExpression.new(val[0], val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 54)
  def _reduce_36(val, _values, result)
     result = MinusExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 55)
  def _reduce_37(val, _values, result)
     result = MultiplyExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 56)
  def _reduce_38(val, _values, result)
     result = ModuloExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 57)
  def _reduce_39(val, _values, result)
     result = DivisionExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 58)
  def _reduce_40(val, _values, result)
     result = AndExpression.new(val[0],val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'SBQL.racc', 59)
  def _reduce_41(val, _values, result)
     result = OrExpression.new(val[0],val[2]) 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

end   # class SBQLParser