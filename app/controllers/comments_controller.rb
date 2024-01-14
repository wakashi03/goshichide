class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to senryu_path(comment.senryu), success: t('defaults.message.created', item: Comment.model_name.human)
    else
      redirect_to senryu_path(comment.senryu), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(senryu_id: params[:senryu_id])
  end
end
