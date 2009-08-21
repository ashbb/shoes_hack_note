# hack003.rb

Shoes.app :width => 200, :height => 200, :title => 'Pulse!' do
  logo = image "shoes-icon-blue.png", :top => 30, :left => 30

  animate 10 do |i|
    i %= 10
    @o.remove if @o
    fill black(0.2 - (i * 0.02))
    strokewidth(3.0 - (i * 0.2))
    stroke rgb(0.7, 0.7, 0.9, 1.0 - (i * 0.1))
    @o = oval(logo.left - i, logo.top - i, logo.width + (i * 2)) 
  end
end
