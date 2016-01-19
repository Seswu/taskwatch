module LogsHelper
  class Maxlength
    def initialize(init_string = "")
      str = init_string.to_s
      @max_length = str.length
      @max_str = str
    end

    def choose_maximum(new_string)
      if new_string.is_a?(Time)
        str = new_string.to_s.chomp(" +0100")
      elsif new_string.is_a?(String)
        str = new_string.to_s
      else
        str = ""
      end
      #str = "testing"
      if str.is_a?(String)
        if str.length > @max_length
          @max_length = str.length
          @max_str = str
        end
      end
    end
  
    def return_max
      @max_length
    end
    
    def return_max_str
      @max_str
    end
  end
end
