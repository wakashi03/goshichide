class SenryusController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @senryus = Senryu.includes(:user).order(created_at: :desc)
  end

  def show
    @senryu = Senryu.find(params[:id])
    @comment = Comment.new
    @comments = @senryu.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @senryu = Senryu.new
  end

  def create
    @senryu = current_user.senryus.build(senryu_params)
    if @senryu.save
      redirect_to senryus_path, success: t('defaults.message.created', item: Senryu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Senryu.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def senryu_params
    params.require(:senryu).permit(:kamigo, :nakashichi, :shimogo)
  end
end
