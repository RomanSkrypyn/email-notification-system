# frozen_string_literal: true

module FlashHelper
  def flash_class(type)
    case type
    when 'alert'
      'danger'
    when 'notice'
      'info'
    end
  end
end
