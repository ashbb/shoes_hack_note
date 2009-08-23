# hack005.rb
class Shoes
  # complete list of styles
  BASIC_S = [:left, :top, :right, :bottom, :width, :height, :attach, :hidden,
             :displace_left, :displace_top, :margin, :margin_left, :margin_top,
             :margin_right, :margin_bottom]
  TEXT_S  = [:strikecolor, :undercolor, :font, :size, :family, :weight,
             :rise, :kerning, :emphasis, :strikethrough, :stretch, :underline,
             :variant]
  MOUSE_S = [:click, :motion, :release, :hover, :leave]
  COLOR_S = [:stroke, :fill]

  {Background => [:angle, :radius, :curve, *BASIC_S],
   Border     => [:angle, :radius, :curve, :strokewidth, *BASIC_S],
   ::Canvas   => [:scroll, :start, :finish, :keypress, *(MOUSE_S|BASIC_S)],
   Check      => [:click, :checked, *BASIC_S],
   Radio      => [:click, :checked, :group, *BASIC_S],
   EditLine   => [:change, :secret, :text, *BASIC_S],
   EditBox    => [:change, :text, *BASIC_S],
   Effect     => [:radius, :distance, :inner, *(COLOR_S|BASIC_S)],
   Image      => MOUSE_S|BASIC_S,
   ListBox    => [:change, :items, :choose, *BASIC_S],
   # Pattern    => [:angle, :radius, *BASIC_S],
   Progress   => BASIC_S,
   Shape      => COLOR_S|MOUSE_S|BASIC_S,
   TextBlock  => [:justify, :align, :leading, *(COLOR_S|MOUSE_S|TEXT_S|BASIC_S)],
   Text       => COLOR_S|MOUSE_S|TEXT_S|BASIC_S}.
  each do |klass, styles|
    klass.class_eval do
      styles.each do |m|
        define_method(m) { style[m] } unless klass.method_defined? m
        define_method("#{m}=") { |v| style(m => v) } unless klass.method_defined? "#{m}="
      end
    end
  end
end
