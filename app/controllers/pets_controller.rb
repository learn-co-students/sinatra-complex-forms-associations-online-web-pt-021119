class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do

    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      p = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = p.id
    else
      @pet.owner_id = params[:pet][:owner_id]

    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    @pet = Pet.find(params[:id])
    if !params["owner"]["name"].empty?
      p = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = p.id

    elsif params[:pet][:owner_ids].count > 1
      redirect to "pets/#{@pet.id}/edit"
    else
      @pet.owner_id = params[:pet][:owner_ids][0]
    end
    @pet.name = params[:pet][:name] if !params[:pet][:name].empty?
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
