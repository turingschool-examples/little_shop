# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all
Review.destroy_all
megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
# ogre.reviews.create!(title: 'poop', rating: 1, content: 'Smells like poop!')
# ogre.reviews.create!(title: 'Awesome!!!', rating: 5, content: 'These things are Awesome! Get one!!! ')
# ogre.reviews.create!(title: 'WTF', rating: 2, content: "He's cute, but rreally, why?!!")
# ogre.reviews.create!(title: 'Does Not Do What It Is Supposed To', rating: 3, content: "Doesn't work!")
# ogre.reviews.create!(title: 'Cute', rating: 2, content: 'It was delivered in a princess outfit. How cute')
# ogre.reviews.create!(title: 'Looks Good', rating: 5, content: 'This thing looks amazing')
# ogre.reviews.create!(title: 'Wish It Had More Muscles', rating: 4, content: "Seriously Sejin's muscles are bigger than this thing!")
