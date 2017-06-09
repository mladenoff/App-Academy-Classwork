def first_anagram?(str1, str2)
  return true if str1.chars.permutation(str1.length).to_a.sort! == str2.chars.permutation(str2.length).to_a.sort!
  false
end

p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("elvis", "lives")    #=> true
p first_anagram?("dagggiy", "isakgiy")    #=> false
puts "next\n\n"

def second_anagram?(str1, str2)
  str1_dup = str1.chars
  str2_dup = str2.chars

  str1.each_char.with_index do |letter, idx1|
    str2.each_char.with_index do |other_letter, idx2|
      str2_dup[idx2] = nil if letter == other_letter
      str1_dup[idx1] = nil if letter == other_letter
    end
  end
  str1_dup == str2_dup
end

p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true
p second_anagram?("dagggiy", "isakgiy")    #=> false
puts "next\n\n"

def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true
p third_anagram?("dagggiy", "isakgiy")    #=> false
puts "next\n\n"

def fourth_anagram?(str1, str2)
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)

  str1.chars.each do |letter|
    hash1[letter] += 1
  end

  str2.chars.each do |letter|
    hash2[letter] += 1
  end

  hash1 == hash2
end

p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true
p fourth_anagram?("aaaa", "bbbb")    #=> false
p fourth_anagram?("dagggiy", "isakgiy")    #=> false
puts "next\n\n"

def fifth_anagram?(str1, str2)
  hash1 = Hash.new(0)

  str1.chars.each do |letter|
    hash1[letter] += 1
  end

  str2.chars.each do |letter|
    hash1[letter] -= 1
  end

  hash1.values.all? { |v| v == 0 }
end

p fifth_anagram?("gizmo", "sally")    #=> false
p fifth_anagram?("elvis", "lives")    #=> true
p fifth_anagram?("aaaa", "bbbb")    #=> false
p fifth_anagram?("dagggiy", "isakgiy")    #=> false
