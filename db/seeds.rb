if User.where(admin: true).count.zero?
  User.create!(username: 'Demi',
               email: 'demilichkangaxx@gmail.com',
               password: '12qwas',
               admin: true)
end

if Category.count.zero?
  Category.create(name: 'Books')
  Category.create(name: 'Movie')
  Category.create(name: 'Sport')
end
