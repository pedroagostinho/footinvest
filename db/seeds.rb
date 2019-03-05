# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Club.destroy_all

CSV_OPTIONS = {
  col_sep: ',',
  quote_char: '"',
  headers: :first_row,
  header_converters: :symbol
}

CSV.foreach('clubs', CSV_OPTIONS) do |row|
  club = Club.new(
    name: row[0],
    logo: row[1],
    city: row[2]
    )
end
