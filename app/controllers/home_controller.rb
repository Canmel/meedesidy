class HomeController < ApplicationController
  require 'util/wether_util'
  before_filter :authenticate_user!

  def index

    @wether = WetherUtil.new

    @users = User.current_user_chart_data

    @cars = Car.find_by_sql('select count(*) count, gerens.name geren_name from cars left join gerens on gerens.id = cars.geren_id group by cars.geren_id')

    @tasks =  Kaminari.paginate_array(Task.current_tasks(current_user)).page(@page).per(@page_size) if params[:passed].nil?

    @passed_tasks =  Kaminari.paginate_array(Task.passed_tasks(current_user)).page(@page).per(@page_size) if params[:passed].present?

    @users_chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart(defaultSeriesType: "pie")
      series = {
          type: 'pie',
          name: '数量',
          data: [
            ['在线', User.current_user_chart_data.size],
            ['离线', User.active.size]
          ]
      }
      f.series(series)
      f.options[:title][:text] = "用户在线状态"
      f.options[:colors] = ['#888888', '#ccc']
      f.plot_options(pie: {
          allowPointSelect: true,
          cursor: "pointer",
          size: "75%",
          dataLabels: {
              enabled: true,
              color: "black",
              style: {
                  font: "9px Trebuchet MS, Verdana, sans-serif"
              }
          }
      })
    end

    @cars_chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart(defaultSeriesType: "pie")
      series = {
          type: 'pie',
          name: '数量',
          data: []
      }
      @cars.each do |car|
        series[:data] << [car[:geren_name], car[:count]]
      end
      f.series(series)
      f.options[:title][:text] = "车型分布"
      f.options[:colors] = ['#888888', '#ccc']
      f.plot_options(pie: {
          allowPointSelect: true,
          cursor: "pointer",
          size: "75%",
          dataLabels: {
              enabled: true,
              color: "black",
              style: {
                  font: "9px Trebuchet MS, Verdana, sans-serif"
              }
          }
      })
    end
  end
end
