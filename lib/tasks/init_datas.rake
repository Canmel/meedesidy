namespace :init_datas do
  task init: :environment do
    init_menus
  end

  def init_menus
    Icon.create(name: "图表", code: 'fa-bar-chart-o', status: 1)
    laptop = Icon.create(name: "布局", code: 'fa-laptop', status: 1)
    Icon.create(name: "表格", code: 'fa-th', status: 1)
    Icon.create(name: "邮件", code: 'fa-envelope', status: 1)
    Icon.create(name: "定位", code: 'fa-map-marker', status: 1)
    cart = Icon.create(name: "购物车", code: 'fa-shopping-cart', status: 1)
    Icon.create(name: "书堆", code: 'fa-tasks', status: 1)
    cogs = Icon.create(name: "设置", code: 'fa-cogs', status: 1)
    Icon.create(name: "用户", code: 'fa-user', status: 1)
    Icon.create(name: "书本", code: 'fa-book', status: 1)
    Icon.create(name: "面板", code: 'fa-dashboard', status: 1)
    Icon.create(name: "换电规则", code: 'fa-sort-amount-asc', status: 1)
    Icon.create(name: "换电", code: ' fa-expand', status: 1)
    money = Icon.create(name: "money", code: 'fa-dollar', status: 1)



    sys = Menu.create(name: '系统权限管理', status: :active, desc: '系统管理', resource_type: 1, parent_id: 1, resource_id: 1, icon_id: cogs.id)
    data = Menu.create(name: '基本数据管理', status: :active, desc: '基本数据管理', resource_type: 1, parent_id: 1, resource_id: 1, icon_id: laptop.id)
    change = Menu.create(name: '换电运行管理', status: :active, desc: '换电运行管理', resource_type: 1, parent_id: 1, resource_id: 1, icon_id: cart.id)
    finance = Menu.create(name: '财务信息管理', status: :active, desc: '财务信息管理', resource_type: 1, parent_id: 1, resource_id: 1, icon_id: money.id)

    Menu.create(name: '用户信息管理', status: :active, desc: '用户信息管理', resource_type: 2, parent_id: sys.id, source: '/users')
    Menu.create(name: '角色信息管理', status: :active, desc: '角色信息管理', resource_type: 2, parent_id: sys.id, source: '/roles')
    Menu.create(name: '菜单信息管理', status: :active, desc: '菜单信息管理', resource_type: 2, parent_id: sys.id, source: '/menus')
    Menu.create(name: '图标信息管理', status: :active, desc: '图标信息管理', resource_type: 2, parent_id: sys.id, source: '/icons')

    Menu.create(name: '车辆信息维护', status: :active, desc: '车辆信息维护', resource_type: 2, parent_id: data.id, source: '/cars')
    Menu.create(name: '车型信息维护', status: :active, desc: '车型信息维护', resource_type: 2, parent_id: data.id, source: '/gerens')
    Menu.create(name: '司机信息维护', status: :active, desc: '司机信息维护', resource_type: 2, parent_id: data.id, source: '/drivers')
    Menu.create(name: '服务公司维护', status: :active, desc: '服务公司维护', resource_type: 2, parent_id: data.id, source: '/companies')
    Menu.create(name: '换电规则管理', status: :active, desc: '换电规则管理', resource_type: 2, parent_id: data.id, source: '/settlementers')

    Menu.create(name: '操作日志查询', status: :active, desc: '车辆信息维护', resource_type: 2, parent_id: change.id, source: '/logs')
    Menu.create(name: '换电信息录入', status: :active, desc: '换电信息录入', resource_type: 2, parent_id: change.id, source: '/change_records')

    Menu.create(name: '财务往来日志', status: :active, desc: '财务往来日志', resource_type: 2, parent_id: finance.id, source: '/finances')
    Menu.create(name: '退款申请管理', status: :active, desc: '退款申请管理', resource_type: 2, parent_id: finance.id, source: '/refunds')

    Role.create(name: 'admin', status: :active, menu_ids: Menu.active.pluck(:id), desc: '超级管理员')
    User.create(name: 'Meedesidy', password: 123123, status: :active, email: 'meedesidy@mee.cn', role_ids: Role.active.pluck(:id))
  end
end