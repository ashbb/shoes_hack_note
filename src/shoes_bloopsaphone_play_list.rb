
Shoes.app :width => 500, :height => 100, 
  :title => 'Bloopsaphone Play Lists'do
  background mediumspringgreen..hotpink, :angle => 90
  style(Link, :stroke => white, :underline => nil, :weight => "bold")
  style(LinkHover, :stroke => gold, :fill => nil, :underline => nil, :weight => "bold")
  nostroke
  
  plists = Dir.glob "./songs/*_by_*.rb"

  i = 0
  plists.each do |list|
    y = 10 + 24 * i
    song, auther = list.split('_by_').collect{|e| File.basename(e, '.rb').gsub('_', ' ')}
    
    rect :width => 480, :height => 20, :left => 10, :top => y, 
      :fill => rgb(75, 0, 130, 0.2), :curve => 5
    para link(song){eval IO.read list}, :left => 20, :top => y
    para strong(auther), :left => 300, :top => y, :stroke => white
    i += 1
  end
end
