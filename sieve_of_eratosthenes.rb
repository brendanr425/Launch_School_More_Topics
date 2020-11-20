class Sieve
  MARKED = :marked
  UNMARKED = :unmarked
  PRIME = :prime

  attr_reader :limit, :range_hash, :sleep_arg

  def initialize(limit)
    hsh = {}
    range = 2..limit
    range.each { |n| hsh[n] = UNMARKED }

    @range_hash = hsh
    @limit = limit
    @sleep_arg = 1/limit
  end

  def find_primes
    loop do
      current_unmarked = unmarked_numbers
      num = current_unmarked.first
      multiple = num

      loop do
        @range_hash[num] = MARKED if current_unmarked.include?(num)
        @range_hash[num] = PRIME if num == current_unmarked.first
        output_range_hash
        sleep(sleep_arg)
        clear
        break if @range_hash[num] == nil
        num += multiple 
      end

      break if unmarked_numbers == []
    end
    prime_numbers
  end

  private

  def unmarked_numbers
    @range_hash.select { |_, mark_status| mark_status == UNMARKED }.keys
  end

  def marked_numbers
    @range_hash.select { |_, mark_status| mark_status == MARKED }.keys
  end

  def prime_numbers
    @range_hash.select { |_, mark_status| mark_status == PRIME }.keys
  end

  def output_range_hash
    puts "Unmarked: #{unmarked_numbers}"
    puts
    puts "Marked: #{marked_numbers}"
    puts
    puts "Primes: #{prime_numbers}"
  end

  def clear
    system 'clear'
  end
end
