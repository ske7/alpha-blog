if User.count.zero?
  User.create!(username: 'Demi',
               email: 'demilichkangaxx@gmail.com',
               password: '12qwas',
               admin: true)
end
