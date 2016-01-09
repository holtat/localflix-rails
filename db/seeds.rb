if User.count == 0
  User.create(name: "Dev", password: "password", password_confirmation: "password")
end
