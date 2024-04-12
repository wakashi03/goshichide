class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.senryu }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: "comments/form", locals: { comment: @comment }),
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.senryu }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(senryu_id: params[:senryu_id])
  end
end
