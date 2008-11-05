# listing_class_and_method.rb
IO.read(gets.chomp).each do |line|
  puts line if /^(class|def|module) / =~ line.strip
end