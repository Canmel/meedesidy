module ApplicationHelper
  def load_menus(level, parent_id)
    Menu.find_by_user current_user.id, level, parent_id if current_user
  end

  def sequence(index)
    (@page.to_i - 1) * @page_size.to_i + index + 1
  end

  def enum_to_select_array(class_name, enum)
    Driver.sexes.to_a.map { |w| [w[0].humanize, w[0]] }
  end

  def form_module_title_render title
    "<div style='float: right;color: #000000;'><h5 align='right'>#{title}</h5></div><br/><hr/>".html_safe
  end
end
