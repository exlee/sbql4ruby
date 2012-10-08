require "lib/SBQL"

SBQL.init("sampledata/data.xml")

# Outputting result of the query
puts SBQL.query <<end
  bag(1,2,3), bag(3,4,5)
end

puts "\n========================================\n\n"

# Outputting result of query (it contains objects inside loaded data.xml)
puts SBQL.query <<end
  emp join dept
end

puts "\n========================================\n\n"

# Outputting raw result (i.e. they can be worked on using Ruby later on)
puts SBQL.raw <<end
  emp where fName="Maciej"
end

puts "\n========================================\n\n"