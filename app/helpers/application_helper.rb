module ApplicationHelper
  def self.sanitize_yaml(code)
    sanitized_code = ""
    code.each_line do |line|
      downcased = line.downcase
      if downcased.include? "description"
        break
      end
      if /.+: .+/ =~ downcased
        sanitized_code << downcased
      end
    end
    return sanitized_code
  end
end
