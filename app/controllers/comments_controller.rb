class CommentsController < ApplicationController
  respond_to :html, :js

  def index
    respond_to do |format|
      format.json do
        @comments = Comment.includes(:user).where(tib_term_id: params[:tib_term_id]).order(id: :asc)
        json = @comments.map do |comment|
          {
            id: comment.id,
            title: comment.title,
            body: comment.body,
            email: comment.user.email
          }
        end
        render json: json
      end
    end
  end

  def create
    respond_to do |format|
      format.html do
        @tib_term = TibTerm.find(params[:tib_term_id])
        @comment = Comment.new(tib_term_id: params[:tib_term_id], user_id: current_user.id, title: params[:comment][:title], body: params[:comment][:body])
        if @comment.save
          redirect_to tib_term_path(@tib_term)
        end
      end
      format.json do
        @tib_term = TibTerm.find(params[:tib_term_id])
        @comment = Comment.new(tib_term_id: params[:tib_term_id], user_id: current_user.id, title: params[:comment][:title], body: params[:comment][:body])

        if @comment.save
          json = {
            id: @comment.id,
            title: @comment.title,
            body: @comment.body,
            email: @comment.user.email
          }
          render json: json
        end
      end
    end
  end
end