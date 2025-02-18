class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # ストレージの設定（ローカルストレージを利用する場合）
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # 保存先のディレクトリを指定
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  # ファイルサイズの制限
  def size_range
    1..5.megabytes # 1MB 〜 5MB
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # 許可する拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # 画像の寸法の制限（幅と高さ）
  process :resize_to_limit => [500, 500]

  # 画像のリサイズ（最大幅500px、高さ500pxに制限）
  def resize_to_limit(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}>"
      img
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  # 設定された最大幅・高さを超える画像をリサイズ
  def resize_to_limit(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}>"
      img
    end
  end
end
