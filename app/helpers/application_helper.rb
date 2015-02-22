module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str: "http://#{str}"
  end

  def fix_time_format(datetime)
    if logged_in? && !current_user.timezone.blank?
      datetime = datetime.in_time_zone(current_user.timezone)
    end

    datetime.strftime("%m/%d/%Y %l:%M%P %Z")
  end

end
