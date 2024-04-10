class SenryusController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_senryu, only: %i[edit update destroy]

  def index
    @senryus = if params[:search].present?
                 Senryu.includes(:user).search_by_all_parts(params[:search]).order(created_at: :desc)
               else
                 Senryu.includes(:user).order(created_at: :desc)
               end
  end

  def show
    @senryu = Senryu.find(params[:id])
    @comment = Comment.new
    @comments = @senryu.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @senryu = Senryu.new
  end

  def edit; end

  def create
    @senryu = current_user.senryus.build(senryu_params)
    if @senryu.save
      redirect_to senryus_path, success: t('defaults.message.created', item: Senryu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Senryu.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @senryu.update(senryu_params)
      redirect_to @senryu, success: t('defaults.message.updated', item: Senryu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Senryu.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @senryu.destroy
      redirect_to senryus_path, success: t('defaults.message.deleted', item: Senryu.model_name.human),
                                status: :see_other
    else
      redirect_to @senryu, danger: t('defaults.message.not_deleted', item: Senryu.model_name.human), status: :see_other
    end
  end

  def favorites
    @favorite_senryus = current_user.favorite_senryus.includes(:user).order(created_at: :desc)
  end

  def ranking
    @ranked_senryus = Senryu.ranked_by_favorites
  end

  def user_senryus
    @user_senryus = current_user.senryus.includes(:user).order(created_at: :desc)
  end

  private

  def senryu_params
    params.require(:senryu).permit(:kamigo, :nakashichi, :shimogo)
  end

  def set_senryu
    @senryu = current_user.senryus.find(params[:id])
  end
end
