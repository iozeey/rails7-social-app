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

    private

    def group_users_params
      params.fetch(:group_users, {}).permit(:group_id)
    end
end
