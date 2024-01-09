class SenryusController < ApplicationController
  def index
    @senryus = Senryu.all.includes(:user).order(created_at: :desc)
  end
end
