# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "這個種子檔案會自動建立一個帳號，並且創建20個groups, 每個group各30個posts"

create_groups = for i in 1..20 do
                    Group.create!([title: "Group no. #{i}", description: "這是用種子建立的第#{i}個討論版", user_id: "1"])
                    GroupUser.create(group_id: i, user_id: 1)
                    for k in 1..30 do
                      Post.create!([group_id: "#{i}", content: "這是用種子建立的第#{k}個留言", user_id: "1"])
                    end
                end
