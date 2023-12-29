module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :success then 'alert alert-success'
    when :info then 'alert alert-info'
    when :warning then 'alert alert-warning'
    when :danger then 'alert alert-error'
    else 'alert'
    end
  end
end
