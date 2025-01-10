# config/initializers/pagy.rb
require 'pagy/extras/semantic'

# 既定値は20件ですが、10件ごとにページ分けしたいときには、以下のように書きます。
# Pagy::VARS[:items] = 10