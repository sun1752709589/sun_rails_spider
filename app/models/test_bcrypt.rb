require 'bcrypt'

my_password1 = BCrypt::Password.create("aaaaaa")
my_password2 = BCrypt::Password.create("aaaaaa")
my_password3 = BCrypt::Password.create("aaaaaa")
puts my_password1
puts my_password2
puts my_password3
puts my_password1 == "aaaaaa"
my_password = BCrypt::Password.new("$2a$10$h4PqD8GwY5gmhurMuEFrzebCQ6i4HHaTFVvkBIR0hfXguxyGGpR4e")
puts my_password == "12345678"