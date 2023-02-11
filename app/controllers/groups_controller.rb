class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /groups or /groups.json
  def index
    @groups = Group.order(created_at: :desc)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @post = Post.new
    @posts = @group.posts
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params.merge(user: current_user))

    respond_to do |format|
      if @group.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("groups", partial: 'groups/group', locals: {group: @group}) }
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@group, partial: 'groups/group', locals: {group: @group}) }
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def created_by_me
    @groups = Group.where(user_id: current_user.id).all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.fetch(:group, {}).permit(:title)
    end
end
