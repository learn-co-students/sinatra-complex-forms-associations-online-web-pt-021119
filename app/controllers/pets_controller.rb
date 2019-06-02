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
    if params["pet"]["owner_id"]
      @pet = Pet.create(params["pet"])
    else
      @owner = Owner.create(name: params["owner_name"])
      @pet = Pet.create(name: params["pet"]["name"], owner_id: @owner.id)
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if params["pet"]["owner_id"] && params[:owner][:name].empty?
      @pet = Pet.find(params[:id])
      @pet.name = params[:pet][:name]
      @pet.owner_id = params[:pet][:owner_id]
      @pet.save
    else
      @owner = Owner.create(params[:owner])
      @pet = Pet.find(params[:id])
      @pet.name = params["pet"]["name"]
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
