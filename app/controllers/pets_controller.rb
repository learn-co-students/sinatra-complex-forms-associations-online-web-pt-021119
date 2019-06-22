class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    @pet = Pet.create(params[:pet])
    if params[:owner][:name] != ""
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      params[:pet][:owner_id] = @owner.id
    end

    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    redirect to "pets/#{@pet.id}"
  end
end