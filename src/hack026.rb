# shoes.rb
 class Shoes
   def self.run path
     [nil]
   end

   def self.args!
    Shoes.app do
      background hotpink..orange, angle: 90
      stack do
        para 'Hello world!'
        para "RELEASE_NAME: #{Shoes::RELEASE_NAME}"
        para "RELEASE_ID: #{Shoes::RELEASE_ID}"
        para "REVISION: #{Shoes::REVISION}"
        para "RUBY_PLATFORM: #{Shoes::RUBY_PLATFORM}"
        para "RUBY_VERSION: #{Shoes::RUBY_VERSION}"
      end
    end
  end
 end
