require 'sinatra/base'
require 'sprockets'
require 'uglifier'
require 'slim'
require 'coffee-script'
require 'sass'
require 'jquery-cdn'
require 'execjs'


class App < Sinatra::Base
  set :views, proc { File.join(root, 'views') }
  set :public_folder, File.join(File.dirname(__FILE__), 'public')

  environment = Sprockets::Environment.new

  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  environment.js_compressor = :uglify

  JqueryCdn.install environment

  get '/' do
    @base_class = 'base_index'
    slim :index
  end

  get '/assets/*' do
    p environment
    env['PATH_INFO'].sub!('/assets', '')
    environment.call(env)
  end
end
