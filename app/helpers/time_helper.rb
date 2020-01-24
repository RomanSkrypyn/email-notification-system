# frozen_string_literal: true

module TimeHelper
  def datetime_format(datetime)
    datetime.strftime('%d-%m-%Y %I:%M%p')
  end
end
