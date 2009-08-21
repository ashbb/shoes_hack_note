# shoes.rb
class Shoes
  def self.run path
      [nil]
  end

  def self.args!
    Shoes.app do
      para 'Hello world!'
    end
  end
end