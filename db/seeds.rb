# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Province.create(name: 'Alberta', pst: 0.0, gst: 0.05, hst: 0.0)
Province.create(name: 'British Columbia', pst: 0.0, gst: 0.0, hst: 0.12)
Province.create(name: 'Manitoba', pst: 0.07, gst: 0.05, hst: 0.0)
Province.create(name: 'New Brunswick', pst: 0.0, gst: 0.0, hst: 0.13)
Province.create(name: 'Newfoundland and Labrador', pst: 0.0, gst: 0.0, hst: 0.13)
Province.create(name: 'Northwest Territories', pst: 0.0, gst: 0.05, hst: 0.0)
Province.create(name: 'Nova Scotia', pst: 0.0, gst: 0.0, hst: 0.15)
Province.create(name: 'Nunavut', pst: 0.0, gst: 0.05, hst: 0.0)
Province.create(name: 'Ontario', pst: 0.0, gst: 0.0, hst: 0.13)
Province.create(name: 'Prince Edward Island', pst: 0.1, gst: 0.05, hst: 0.0)
Province.create(name: 'Quebec', pst: 0.075, gst: 0.05, hst: 0.0)
Province.create(name: 'Saskatchewan', pst: 0.05, gst: 0.05, hst: 0.0)
Province.create(name: 'Yukon', pst: 0.0, gst: 0.05, hst: 0.0)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
