class QiniuUtil
  def self.upload2qiniu(file, name = nil)
    require 'qiniu'
    put_policy = Qiniu::Auth::PutPolicy.new(QINIU_BUCKET)
    if name.nil?
      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
        put_policy,
        file
      )
      result["key"]
    else
      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
        put_policy,
        file,
        name
      )
      name
    end
  end

  def self.upload2qiniu!(file, name = nil)
    require 'qiniu'

    putpolicy = Qiniu::Auth::PutPolicy.new(QINIU_BUCKET, "#{name}.png", 3600)

    uptoken = Qiniu::Auth.generate_uptoken(putpolicy)

    file_path = "public/users/rqrcode/temp_user.png"

    result = Qiniu.upload_file uptoken: uptoken, file: file_path, bucket: QINIU_BUCKET, key: "#{name}.png"

  rescue StandardError
    raise "上传二维码失败"
    result["key"]
  end

  def self.deleteQiniuRqrcode(name = nil)
    require 'qiniu'
    code, result, response_headers = Qiniu::Storage.delete(
      Rails.configuration.qiniu_bucket,
      name
    )
  end

  def self.deleteQiniuPhoto(name = nil)
    require 'qiniu'
    code, result, response_headers = Qiniu::Storage.delete(
      Rails.configuration.qiniu_bucket,
      name
    )
  end
end
