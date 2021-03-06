class ImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  # エラー回避のため、コメントアウト
  # process :convert => 'png'
  # process :tags => ['avatar']

  # version :standard do
  #   process :resize_to_fill => [100, 150, :north]
  # end

  # version :thumbnail do
  #   process :resize_to_fit => [50, 50]
  # end

  # Cloudinaryから画像を参照
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # public配下に作成されるcacheの場所を変更（ローカル環境）
  def cache_dir
    # 下記３つは、if文を入れる前に使用・試行していたロジック。
    # "cache"
    # "tmp/uploads"
    # # "#{Rails.root}/tmp/uploads" ：NG
    if Rails.env.production?
    # if Rails.env.development?
    # ：『cache』の保存先変更を確認する為に使用したが、本番環境には適用できず。
      "#{Rails.root}/tmp/uploads"
    else
      "cache"
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    1..5.megabytes
  end

  def public_id
    return model.id
  end

  # team-aで使用していた『image_uploader』内容のみ
  # storage :file
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # def size_range
  #   1..5.megabytes
  # end


  # team-aで使用していた『image_uploader』内容全て
  # # Include RMagick or MiniMagick support:
  # # include CarrierWave::RMagick
  # # include CarrierWave::MiniMagick

  # # Choose what kind of storage to use for this uploader:
  # storage :file
  # # storage :fog

  # # Override the directory where uploaded files will be stored.
  # # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # # Provide a default URL as a default if there hasn't been a file uploaded:
  # # def default_url(*args)
  # #   # For Rails 3.1+ asset pipeline compatibility:
  # #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  # #
  # #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # # end

  # # Process files as they are uploaded:
  # # process scale: [200, 300]
  # #
  # # def scale(width, height)
  # #   # do something
  # # end

  # # Create different versions of your uploaded files:
  # # version :thumb do
  # #   process resize_to_fit: [50, 50]
  # # end

  # # Add a white list of extensions which are allowed to be uploaded.
  # # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # def size_range
  #   1..5.megabytes
  # end

  # # Override the filename of the uploaded files:
  # # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # # def filename
  # #   "something.jpg" if original_filename
  # # end
end
