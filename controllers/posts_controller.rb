class PostsController < Sinatra::Base # base module allows us to use HTTP verbs

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    "Hello World!"
  end

end
