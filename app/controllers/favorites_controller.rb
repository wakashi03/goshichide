class FavoritesController < ApplicationController
  def create
    senryu = Senryu.find(params[:senryu_id])
    current_user.favorite(senryu)
    redirect_back fallback_location: senryus_path, success: t('.success')
  end

  def destroy
    senryu = current_user.favorites.find(params[:id]).senryu
    current_user.unfavorite(senryu)
    redirect_back fallback_location: senryus_path, success: t('.success'), status: :see_other
  end
end
