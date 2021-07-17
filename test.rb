# FIXME: documentation
class Test
    def funky_stuff(hi: :you)
      test = false
      this = :nice
      omg_this_is_long = "hell yeah!"

        deep_array = [[[[:boo]]]]

      funky_hash = {
        :test => false,
        :this => :nice,
        :omg_this_is_long => "hell yeah!"
      }
    end

  def test
    %w(this that).map {
      |i| puts i
    }
  end
end

# TODO: this is fun
t = Test.new
t.funky_stuff
t.test

module Blub
  class Zen
    def initialize
      puts "init done!"
    end

    def greet(name: "noone")
      puts "hi, #{name}"
    end
  end
end


