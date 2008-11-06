# hack002.rb

#file = 'C:/rubyprograms/shoes/shoes_hack_note/0.r1057/lib/shoes.rb'
file = '../0.r1057/lib/shoes.rb'

# No.1
IO.read(file).each do |line|
  puts line if /^(class|def|module) / =~ line.strip
end

# No.2
IO.read(file).each do |line|
  line.strip.gsub(/^(class|def|module) /){print line}
end