class RobotWorldApp < Sinatra::Base

  get '/' do
    erb :home
  end

  get '/robots' do
    @robots = RobotWorld.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotWorld.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = RobotWorld.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = RobotWorld.find(id.to_i)
    erb :edit
  end

  delete '/robots/:id/delete' do |id|
    RobotWorld.delete(id.to_i)
    redirect '/robots'
  end

  put '/robots/:id' do |id|
    RobotWorld.update(id.to_i, params[:robot])
    redirect '/robots'
  end

  get '/dashboard' do
    @avg_age = RobotWorld.avg_age
    erb :dashboard
  end

  not_found do
    erb :error
  end

end
