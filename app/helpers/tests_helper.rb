module TestsHelper
  def convert_roman(number) 
    roman_map = Hash[10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I"]
    roman_result = ""
    if number < 20
      roman_map.keys.sort{ |a,b| b <=> a }.each do
        |n|
        while number >= n
          number = number - n
          roman_result = roman_result + roman_map[n]
        end
      end
    return roman_result
    else
      return "??"
    end
  end
end
