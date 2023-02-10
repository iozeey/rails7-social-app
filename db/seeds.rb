
10.times do |index|
    begin
        User.create!({:email => "user#{index}@example.com", :password => 'password', :password_confirmation => 'password'})
    rescue => ex
        puts ex
    end
end


5.times do |index|
    begin
        user = User.all.sample
        Group.create!({:title => "Group#{index}", :user => user, last_activity: Date.new})
    rescue => ex
        puts ex
    end
end

5.times do |index|
    begin
        user_id = User.all.sample.id
        group_id = Group.all.sample.id
        GroupUser.create!({:user_id => user_id, :group_id => group_id})
    rescue => ex
        puts ex
    end
end
