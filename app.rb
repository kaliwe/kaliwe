require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'uglifier'
require 'slim'
require 'coffee-script'
require 'sass'
require 'execjs'

class App < Sinatra::Base
  set :views, proc { File.join(root, 'views') }
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  set :assets_precompile, %w(app.js app.css)
  set :assets_paths, %w(assets/javascripts assets/stylesheets
                        vendor/assets/javascripts)
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier

  register Sinatra::AssetPipeline
  get '/' do
    @base_class = 'base_index'
    slim :index
  end
end
