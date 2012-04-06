module Common
  
# Implementing a Stack with Two Queues: A Simple Ruby Demonstration
# -----------------------------------------------------------------
# 
# How do we turn pipes into stacks without resorting to index or
# pointer manipulation? That is, suppose we have only the ability to
# create FIFOs for pipe-like behavior but we want to create LIFOs
# for alternative stack-like behavior.
# 
# A FIFO is an opaque structure that allows items to be placed or
# pushed onto it at one end (head) and removed or pulled from it, one
# at at time and in sequence, from the other end (tail). A LIFO is a
# similarly opaque structure that allows items to be pushed onto it at one
# end (head or top) and removed or popped from it from that same end
# (head). This means that items of a LIFO are removed one at a time
# but in the reverse order of when they were entered. Let us further
# suppose that our only FIFO primitives are an append operator 'push'
# and a pull operator 'shift'. 'push' adds elements to the head of
# the FIFO and 'shift' grabs (and removes) items from the tail of
# the structure.
# 
# Therefore, we want to build a stack (LIFO) using the pipe
# (FIFO) structure and its two primitive operators, 'push' and
# 'shift'. Essentially, we wish to combine 'push' (onto head) and
# 'shift' (from tail) pipe operators in some fashion to simulate 'push'
# (onto head) and 'pop' (from head) stack operators.
# 
# The following short Ruby program demonstrates a simple solution to
# this puzzle. Basically we shift items between two FIFO structures
# to simulate the operations of a stack.  But this program is notable
# less in the algorithm selected and more in the way Ruby expresses the
# steps required. Interesting Ruby idioms include parallel assignment,
# variable length argument lists, and simple method definitions
# and usage.
#
# Copyright (c) 2008 Technetra Corp
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# Implementation of Stack Using Two Queues


  class LIFOStack
  
    def initialize(*s)
      @q1 = []
      @q2 = []
      s.each { |e| push e }
    end
  
    def push(v)
      # pure FIFO allows only 'push' (onto head) and 'shift' (from tail)
      # LIFO requires 'push' (onto head) and 'pop' (from head)
      empty_queue, full_queue = @q1.length == 0 ? [ @q1, @q2 ] : [ @q2, @q1 ]
      empty_queue.push v
      until (v = full_queue.shift).nil? # shift each item from non-empty queue,
        empty_queue.push v              # pushing it onto initially empty queue:
                                        # produces new full queue in reverse entry order
      end 
    end
  
    def pop()
      full_queue = @q1.length > 0 ? @q1 : @q2
      # full queue has been maintained in reverse order
      # by the push method of the Stack class, so a simple
      # shift is all that is needed to simulate a stack
      # pop operation
      el = full_queue.shift
    end
  
    def empty?()
      @q1.length == 0 && @q2.length == 0
    end
  
  end
  
end