class StringUtils
  BLANK_RE = /\A[[:space:]]*\z/

  # This is copied directly from ActiveSupport:
  # A string is blank if it's empty or contains whitespaces only:
  #
  #   StringUtils.blank?('').blank? # => true
  #   StringUtils.blank?('   ')     # => true
  #   StringUtils.blank?("\t\n\r")  # => true
  #   StringUtils.blank?(' blah ')  # => false
  #
  # Unicode whitespace is supported:
  #
  #   StringUtils.blank?("\u00a0")  # => true
  #
  # @return [true, false]
  def self.blank?(string)
    BLANK_RE === string
  end
end
