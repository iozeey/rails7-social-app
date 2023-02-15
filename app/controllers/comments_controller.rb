class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.order(created_at: :desc)
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id]))
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @comment.save
        format.turbo_stream do 
          if @comment.parent_id.nil? == false
            render turbo_stream: [
              turbo_stream.append("replies_post_#{@post.id}_comment_#{@comment.parent_id}", partial: 'comments/replied', locals: { post: @post, comment: @comment }),
              turbo_stream.replace("comment_reply_form_#{@post.id}", partial: 'comments/reply', locals: { post: @post, comment: @comment }),
              turbo_stream.replace("notification", partial: 'layouts/notice', locals: { notice: "Comment was successfully created."})
            ]
          else                                    
            render turbo_stream: [
              turbo_stream.append('all_comment', partial: 'comments/comment', locals: { post: @post, comment: @comment }),
              turbo_stream.replace('comment_form', partial: 'comments/form', locals: { post: @post, comment: Comment.new }),
              turbo_stream.replace("notification", partial: 'layouts/notice', locals: { notice: "Comment was successfully created."})
            ]
          end
        end
        format.html { redirect_to  @post, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('comment_form',
                                partial: "comments/form",
                                locals: {comment: @comment})
            ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: [
            turbo_stream.remove("post_#{@post.id}_comment_#{@comment.id}"),
            turbo_stream.replace("notification", partial: 'layouts/notice', locals: { notice: "Comment was successfully destroyed." }),
          ]
      end
      
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.fetch(:comment, {}).permit(:post_id, :content, :parent_id)
    end
end