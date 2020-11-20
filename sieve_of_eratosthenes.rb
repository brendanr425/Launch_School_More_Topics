=begin

Notes:

- This is an algorithim that will find all prime numbers within a given range starting
from 2.

- All multiples of the starting number will be marked.

- Once the end of the range is reached, iteration will start from the first unmarked
number and mark all the unmarked multiples of said number.

- The starting number of each iteration will always be a prime number and should be added
to a list of primes.



Data Structures:

- A 'Sieve' class will be created.

- Sieve objects will be initialized with an integer argument denoting the end of the
range.

- A range should be created which will start from 2 up to and including the integer
argument.

- Prime numbers should be shoveled into an array.

- Hash should be created that denotes which numbers in the range are marked or unmarked.
Prior to iteration, all integers should be unmarked.

- Two constants 'MARKED' and 'UNMARKED' should be assigned to symbols ':marked' and
':unmarked'.



Algorithim: 

- Create a 'Sieve' class.

- Create three constants 'MARKED', 'UNMARKED' and 'PRIME' and assign them to symbols 
':marked', ':unmarked' and ':prime'.

- The Sieve class will have an initialize method that accepts an integer argument (limit).

- Assign a local variable 'hsh' to an empty hash.

- Assign a local variable 'range' to (2..limit).

- 'limit' will be assigned to an instance variable. Create corresponding 'getter'.

- Invoke the 'each' method on 'range' and name the block variable 'n'. Within the block, 
'hsh[n] = UNMARKED'. This will assign every number from 2 to 'limit' (keys) a corresponding
':unmarked' symbol value. 

- Assign the instance variable '@range_hash' to 'hsh' and create a corresponding 'getter'
method.

- Create a method 'unmarked_numbers' that will invoke the 'select' method on '@range_hash'
with block variables '_' (keys) and 'mark_status' (values). The block will contain the
following conditional: mark_status == UNMARKED. This will return a hash of only the 
unmarked values within @range_hash. 

- Create a method 'marked_numbers' that calls select on @range_hash and contains the
following conditional within the block: mark_status == MARKED. Implementation is
identical to the 'unmarked_numbers' method with the only difference being the conditional
contained within the select block.

- Create a method 'prime_numbers' that calls select on @range_hash and contains the
following conditional within the block: mark_status == PRIME.

- Create 'primes' instance method.

- The 'primes' method should iterate through @range_hash starting with multiples of two. 
Once the first iteration is complete, the multiple to be iterated by should be incremented. 
With each iteration, the starting number should be left unmarked because it's a prime 
number. In order to accomplish this, we need to iterate through the unmarked numbers and 
mark the first number 'PRIME'.

- Create a method 'find_primes' that will implement the aforementioned algorithim. 

- We need to keep track of the index as we're iterating through 'unmarked_numbers'
because the multiple will be incremented with each iteration. Since we're iterating
through a hash, the 'keys' will act as the indicies since they represent each integer
contained within the range.

- The condition of the loop's break statement should return 'true' when the value
associated with unmarked_numbers is an empty hash.

- We'll create two variables. A 'multiple' variable, which will represent the number to
be incremented by and will be assigned with the start of each iteration. The other will be
a 'num' variable, which will represent the numbers within the range.

- Let's break it down into steps: 

- Step 1: Begin the 'unmarked_numbers' loop, marking the first number within the range
as a prime number.

- Step 2: Increment the 'num' variable by 'multiple'. 

- Step 3: All subsequent numbers will be marked as simply 'marked' numbers.

- Step 4: Once the end of the range is reached, the loop should start from the beginning of
the range, assigning the num and multiple variables to the first integer in
unmarked_numbers.

- We should implement a nested loop. The nested loop will be what we use to iterate
through the entirety of the range. It should be broken once 'num' is greater than the 
last number in the range (unmarked_keys). The 'num' variable will be incremented by the
'multiple' variable.

- The parent loop will be what assesses the aforementioned 'break' condition and assigns
the 'num' and 'multiple' variables' values to set the criteria for iterating through the
range.

- We need to bear in mind that the @range_hash instance variable is what needs to be
affected in each of these iterations.

- Therefore, we should use the 'unmarked_numbers' method as a means of accessing the 
integers that we use to iterate through the @range_hash.

- If we append the 'keys' method to the 'select' block within the unmarked_numbers method
it will return an array of all the integers that are unmarked.

- Our means of iterating through @range_hash should be sorting through the 'unmarked
numbers'. However, we should initialize a variable and set it equal to whatever the
current value of unmarked_numbers returns as a means of saving its current state.

- Set a current_unmarked variable equal to unmarked_numbers in the parent loop so the
new value is set before each iteration.

- We need to set the 'multiple' variable equal to current_unmarked.first since
the first number in the range is what we'll use to increment the index.

- The actual variable we'll use for the index we'll call 'num' and we'll set it equal to
current_unmarked.first as well since this will be our starting point.

- As a means of ensuring we are marking the appropriate values within @range_hash, we
should use a conditional to ensure the number in question is present within
current_unmarked.

- We need to set the first number of current_unmarked equal to 'PRIME' with each iteration
of the nested loop.
=end

class Sieve
  MARKED = :marked
  UNMARKED = :unmarked
  PRIME = :prime

  attr_reader :limit, :range_hash

  def initialize(limit)
    hsh = {}
    range = 2..limit
    range.each { |n| hsh[n] = UNMARKED }

    @range_hash = hsh
    @limit = limit
  end

  def output_range_hash
    puts "Unmarked: #{unmarked_numbers}"
    puts
    puts "Marked: #{marked_numbers}"
    puts
    puts "Primes: #{prime_numbers}"
  end

  def find_primes
    sleep_arg = 1/limit if limit > 0

    loop do
      current_unmarked = unmarked_numbers
      num = current_unmarked.first
      multiple = num

      loop do
        @range_hash[num] = MARKED if current_unmarked.include?(num)
        @range_hash[num] = PRIME if num == current_unmarked.first
        output_range_hash
        sleep(sleep_arg) if sleep_arg != nil
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

  def clear
    system 'clear'
  end
end
