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
  end

  def find_primes
    idx = 0
    loop do
      current_unmarked = unmarked_numbers
      range_key = current_unmarked[idx]
      multiple = range_key
      loop do
        if current_unmarked.include?(range_key) && range_key != multiple
          @range_hash[range_key] = MARKED 
        end

        if limit <= 20
          output_range_hash(multiple)
          sleep(0.5)
          clear
        end

        break if @range_hash[range_key] == nil
        range_key += multiple
      end
      idx += 1
      break if unmarked_numbers.last == multiple
    end
    puts "Your prime numbers are: #{unmarked_numbers}"
    puts
    unmarked_numbers
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

  def output_range_hash(multiple)
    puts "Unmarked: #{unmarked_numbers}"
    puts
    puts "Marked: #{marked_numbers}"
    puts
    puts "Current multiple: #{multiple}"
  end

  def clear
    system 'clear'
  end
end
