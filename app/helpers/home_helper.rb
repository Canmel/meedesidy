module HomeHelper
  def abbr_name str
    return str if str.length < 9
    new_str = str[0,11]
    new_str << "..."
  end
end
