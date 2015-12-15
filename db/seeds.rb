# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Category.create(name: "Hot Drinks", description: "Try our delicious Coffees and Teas")
Category.create(name: "Soft Drinks", description: "All the product lines form Coke and Pepsi")
Category.create(name: "Favorites", description: "Bestseller products")
Category.create(name: "Pastry", description: "Coffees and Teas")
Category.create(name: "Cakes and Pies", description: "Cookies, Pies, cakes and other mind twisting pastrys")

Supply.create(name: "Coffee Beans", price: "40.0", unity: "kg", stock: "100")
Supply.create(name: "Milk", price: "2.00", unity: "l", stock: "100")
Supply.create(name: "Suggar", price: "3", unity: "kg", stock: "100")
Supply.create(name: "Chocolate", price: "25.20", unity: "kg", stock: "100")
