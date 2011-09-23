module Kernel
 private
    def this_method_name
      caller[0] =~ /`([^']*)'/ and $1
    end
end


class Foo
 def test_method
   this_method_name
 end
end

puts Foo.new.test_method    # => test_method
