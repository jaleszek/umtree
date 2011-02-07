require 'faker'

namespace :db do
  desc "Fill microposts table with sample data"
  task :make_micropost=>:environment do
    Category.all.each do |category|
      50.times do
        category.posts.create!(
	  :content => Faker::Lorem.sentence(5),
	  :title => ('a'..'z').to_a.shuffle[0..11].join,
         :city => Faker::Lorem.words(1).to_s.capitalize,
         :street => Faker::Lorem.words(1),
         :user_id=>3          
		) if category.parent_id!=22 && !category.parent_id.nil?
      end
    end
  end
end
