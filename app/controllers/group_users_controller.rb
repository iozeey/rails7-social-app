class GroupUsersController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @group_users = current_user.groups.all
    end
end
