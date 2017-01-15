module DriversHelper
  def sex_array
    Driver.sexes_i18n.map{ |sex| [ sex[1], sex[0]] }
  end
end
