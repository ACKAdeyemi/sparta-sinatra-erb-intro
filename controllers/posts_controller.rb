class PostsController < Sinatra::Base # base module allows us to use HTTP verbs

  configure :development do
    register Sinatra::Reloader
  end

  # set root to parent directory of current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory corretly
  set :views, Proc.new { File.join(root, "views") }

  $posts = [
    {
      :id => 0,
      :title => "Post 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 1,
      :title => "Post 2",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 2,
      :title => "Post 3",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
  ]

  # root
  get '/posts' do

    @title = "Posts Index" # global variable, use them sparingly

    erb :'posts/index'
  end

  get '/posts/:id' do

    id = params[:id].to_i

    @title = "Show Post"
    @post = $posts[id]

    erb :'posts/show'
  end

end
