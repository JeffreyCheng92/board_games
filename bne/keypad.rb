class Keypad
  attr_reader :key_history, :code_bank, :mode_keys, :code_length

  def initialize(code_length = 4, mode_keys = [1, 2, 3])
    @key_history = []
    @code_bank = Array.new
    @mode_keys = mode_keys
    @code_length = code_length
  end

  def press(num)
    if key_history.length >= code_length && mode_keys.include?(num)
      code = key_history[-4..-1].join
      code_bank << code if not code_bank.include?(code)
    end

    key_history << num
  end

  def all_codes_entered?
    code_bank.sort == (0..9999).to_a.map { |x| "%04d" % x }
  end
end
