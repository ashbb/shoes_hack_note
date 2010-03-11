# hack021.rb
require 'irb/ruby-lex'
require 'stringio'

STDOUT.sync = true

class MimickIRB < RubyLex
  def initialize
    super
    set_input StringIO.new
  end

  def run str
    @io << str
    @io.rewind
    l = lex
    eval l, TOPLEVEL_BINDING
  end
end

IRBalike = MimickIRB.new
$stdout = StringIO.new

STDOUT.puts IRBalike.run("a = 1;")
STDOUT.puts IRBalike.run("b")
