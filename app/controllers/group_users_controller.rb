class GroupUsersController < ApplicationController
    before_action :authenticate_user!    
  
    def index
        @group_users = current_user.groups.all
    end

    # POST /group_users or /group_user.json
    def create
        @group_user = GroupUser.new(group_users_params.merge(user_id: current_user.id))

        respond_to do |format|
            if @group_user.save
                format.html { redirect_to group_url(@group_user), notice: "Joined successfully." }
                format.json { render :show, status: :created, location: @group_user }
            else
                format.html { redirect_to groups_url, alert: "Unable to join." }
                format.json { render json: @group_user.errors, status: :unprocessable_entity }
            end
        end
    end

      # DELETE /groups/1 or /groups/1.json
    def destroy
        @group_user = GroupUser.where(group_id: params[:id], user_id: current_user.id).first

        @group_user.destroy

        respond_to do |format|
        format.html { redirect_to groups_url, notice: "Successfully left." }
        format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
        @group_user = GroupUser.find(group_users_params[:group_id])
    end

    def group_users_params
      params.fetch(:group_users, {}).permit(:group_id)
    end
end
