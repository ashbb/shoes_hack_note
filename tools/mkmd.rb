# mkmd.rb

PATH = 'http://github.com/ashbb/shoes_hack_note/tree/master/md/'


# Import source code ../src/***.rb and create links to ../images/***.png (or.jpg)
def read_src name
  IO.readlines('../src/' + name).collect{|c| "\t" + c}
end

Dir.glob("../md/*.md").each do |file|
  lines = IO.readlines(file)
  open(file, 'w') do |f|
    lines.each do |line|
      new_line = line
      line.sub(/^# *(.*\.rb)/){new_line = read_src($1)}
      #line.sub(/^# *(.*\.(png|jpg|gif))/){new_line = make_link($1)}
      f.puts new_line
    end
  end
end
