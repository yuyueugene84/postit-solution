# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(id: 1, username: 'overlord', timezone: 'Central Time (US & Canada)', role: 'admin', password: 'overlord', password_digest: '$2a$10$qD01eoBc2OruynicF5zte.ojAuRn/bttP7LnUqz5km.rXOxO8Lqyy')
