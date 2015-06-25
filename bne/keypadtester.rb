require_relative "keypad"
require "set"
require "byebug"

class KeypadTester
  attr_reader :length, :mode_keys, :keypad, :memory, :history, :repeats

  def initialize(length = 4, mode_keys = [1, 2, 3])
    @length = length
    @mode_keys = mode_keys << mode_keys.shift
    @keypad = Keypad.new(@length, @mode_keys)
    @memory = Set.new
    @history = []
    @repeats = Hash.new(0)
  end

  def run
    (0...10**length).each do |num|
      num_str = num.to_s.rjust(length, "0")
      unless memory.include?(num_str)
        length.times do |i|
          keypad.press(num_str[i].to_i)
          history << num_str[i].to_i
          @repeats[num_str] += 1
        end
        mode_num = mode_keys[0]
        keypad.press(mode_num)
        history << mode_num
        mode_keys << mode_keys.shift
        history_help
      end
    end
  end

  def history_help
    history.each_with_index do |num, idx|
      if mode_keys.include?(num) &&
      !memory.include?(history[idx - 4..idx - 1].join) &&
      idx > 4
        memory << history[idx - 4..idx - 1].join
      end
    end
    @history = history[-5..-1] if history.length > 5
  end

  def info
    puts "Number of key presses: #{keypad.key_history.length}"
    puts "Codes tested: #{keypad.code_bank.length}"
    puts "There were #{calc_repeats} repeated codes"
    p keypad.all_codes_entered?
  end

  def calc_repeats
    test_arr = []
    repeats.select { |k, v| test_arr << k if v > 4}
    test_arr.length
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KeypadTester.new
  k.run
  k.info
end
