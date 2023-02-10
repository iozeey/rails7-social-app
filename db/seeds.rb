
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
        Group.create!({:title => "Group#{index}", :user => user})
    rescue => ex
        puts ex
    end
end