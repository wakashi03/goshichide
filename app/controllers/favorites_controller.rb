class FavoritesController < ApplicationController
  def create
    @senryu = Senryu.find(params[:senryu_id])
    current_user.favorite(@senryu)
  end

  def destroy
    @senryu = current_user.favorites.find(params[:id]).senryu
    current_user.unfavorite(@senryu)
  end
end
