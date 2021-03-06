require_relative 'emojis'
require_relative 'exceptions'

module Emoji
  module_function

  def allowed_characters
    @allowed_characters = emojis + exceptions
    @allowed_characters.join.chars
  end

  def allowed?(symbol)
    return true if allowed_characters.include?(symbol)

    false
  end
end

class String
  def has_allowed?
    chars.each do |char|
      return true if Emoji.allowed?(char)
    end

    false
  end

  def has_disallowed?
    chars.each do |char|
      return true unless Emoji.allowed?(char)
    end

    false
  end

  def allowed
    @output = ''
    chars.each do |char|
      @output += char if Emoji.allowed?(char)
    end
    @output
  end

  def disallowed
    @output = ''
    chars.each do |char|
      @output += char unless Emoji.allowed?(char)
    end
    @output
  end
end
