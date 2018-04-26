namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    %w[db:drop db:create db:migrate].each do |task|
      Rake::Task[task].invoke
    end
    puts "You will be prompted to create data for project"
    
    Settings.users.each do |user|
      User.create name: user.name, email: user.email, password: user.password,
        password_confirmation: user.password_confirmation, activated: user.activated,
        role: user.role
    end
    
    Settings.authors.each do |author|
      for i in 1..100 do
        Author.create name: author.name + i.to_s
      end
    end
    
    Settings.categories.each do |category|
      Category.create name: category.name
    end
    
    Settings.books.each do |book|
      for i in 1..100 do
        Book.create title: book.title + i.to_s, publisher: book.publisher, author_id: i,
        describe: book.describe, cover_image: open(book.cover_image)
      end
    end
    
    for i in 1..100 do
      BookCategory.create book_id: i, category_id: 1
    end
    
    for i in 1..50 do
      BookCategory.create book_id: i, category_id: 2
    end
    
    for i in 51..100 do
      BookCategory.create book_id: i, category_id: 3
    end
  end
end