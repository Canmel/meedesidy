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

  # 划分表单模块
  def form_module_title_render title
    "<div style='float: right;color: #000000;'><h5 align='right'>#{title}</h5></div><br/><hr/>".html_safe
  end

  # 枚举类型的option的集合　[{"k" => "0", "v" => "1"}]
  def enum_colect class_name, enum
    collect_class = class_name.constantize
    @enum_select_colectt = []
    collect_class.send(enum).length.times{ |index|
      @enum_select_colectt << { "k" => collect_class.send(enum).values[index], "v" => collect_class.send("#{enum}_i18n").values[index] }
    }
    @enum_select_colectt
  end

  def class_colect class_name, colum
    collect_class = class_name.constantize
    @colum_select_collect = []
    collect_class.all.map { | item |
      @colum_select_collect << { "k" => item.send(colum), "v" => item.send(colum)}
    }
  end

  def current_url
    url = request.url.to_s
    url.split("/")[3]
  end
end
