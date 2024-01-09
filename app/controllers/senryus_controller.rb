class SenryusController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  
  def index
    @senryus = Senryu.all.includes(:user).order(created_at: :desc)
  end
end
