module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str: "http://#{str}"
  end

  def fix_time_format(datetime)
    datetime.strftime("%m/%d/%Y %l:%M%P %Z")
  end

end
