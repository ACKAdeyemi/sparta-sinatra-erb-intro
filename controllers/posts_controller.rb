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

  # root - index
  get '/posts' do
    @title = "Posts Index" # global variable, use them sparingly
    @posts = $posts

    erb :'posts/index'
  end

  # new
  get '/posts/new' do
    @title = "New Post" # global variable, use them sparingly

    @post = {
      :id => "",
      :title => "",
      :body => ""
    }

    erb :'posts/new'
  end

  # show
  get '/posts/:id' do
    id = params[:id].to_i

    @title = "Show Post"
    @post = $posts[id]

    erb :'posts/show'
  end

  # create
  post '/posts' do
    # puts params # on submit, form data submits to URL

    id = $posts.last[:id] + 1

    new_post = {
      :id => id,
      :title => params[:title],
      :body => params[:body]
    }

    puts new_post
    $posts.push new_post

    redirect '/posts' # redirect is a get request
  end

  # edit
  get '/posts/:id/edit' do
    id = params[:id].to_i

    @post = $posts[id]
    @title = @post[:title]
    # @title = "Edit Page #{id+1}"

    erb :'posts/edit'
  end

  # update
  put '/posts/:id' do

    id = params[:id].to_i

    post = $posts[id] # get hash from array

    post[:title] = params[:title] # update hash with values from URL/params
    post[:body] = params[:body]

    $posts[id] = post # save new data back into array

    redirect '/posts'
  end

  # destroy
  delete '/posts/:id' do
    id = params[:id].to_i

    $posts.delete_at id

    redirect '/posts'
  end

end
