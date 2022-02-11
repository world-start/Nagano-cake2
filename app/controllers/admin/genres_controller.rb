class Admin::GenresController < ApplicationController
  
  
  def create
     @genre = Genre.new(genre_params)
  if @genre.save
    redirect_to admin_genres_path 
  else
    render admin_genres_path
  end
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  #   genre.save
  #   redirect_to admin_genres_path 
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    #binding.pry
    @genre.update(genre_params)
  if @genre.save
    redirect_to admin_genres_path
  else
    render edit_admin_genre_path(@genre)
  end
  end
  
  # "genre"=>{"name"=>"ビスケット"} genreの中のnameに格納されたビスケットを取り出す。
  private
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
