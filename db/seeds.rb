
10.times do |index|
    begin
        User.create!({:email => "user#{index}@example.com", :password => 'password', :password_confirmation => 'password'})
    rescue => ex
        puts ex
    end
end