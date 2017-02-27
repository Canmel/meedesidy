module UsersHelper
  def all_role
    Role.where(status: Role.statuses[:active])
  end

  def downloadFromqiniu(fileName)
    require 'qiniu'

    primitive_url = "http://olzjsogr4.bkt.clouddn.com/#{fileName}"
    download_url = Qiniu::Auth.authorize_download_url(primitive_url)
  end
end
