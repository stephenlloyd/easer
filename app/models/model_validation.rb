class ModelValidation

  def initialize
    @messages = Array.new
  end

  def is_valid?
      @messages.empty?
  end

  def add_validation_message(message)
   @messages << message
  end

  def formatted_messages
    message_shown = ""
       @messages.each do |message|
         message_shown = message_shown + message + "<br/>"
       end
    return message_shown
  end

end