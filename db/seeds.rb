# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'byebug'

Club.destroy_all
Competition.destroy_all
New.destroy_all

CSV_OPTIONS = {
  col_sep: ';',
  quote_char: '"',
  headers: :first_row,
  header_converters: :symbol
}
















































































CSV.foreach('./db/clubs.csv', CSV_OPTIONS) do |row|
  club = Club.new(
    name: row[0],
    logo: row[1],
    city: row[2]
    )
  club.save
end

CSV.foreach('./db/competitions.csv', CSV_OPTIONS) do |row|
  competition = Competition.new(
    name: row[0],
    logo: row[1]
    )
  competition.save
end

CSV.foreach('./db/news.csv', CSV_OPTIONS) do |row|
  byebug
  noticia = New.new(
    date_time: row[0],
    tag: row[1],
    title: row[2],
    summary: row[3],
    content: row[4],
    club: Club.find(row[5].to_i),
    player: Player.find(ow[6].to_i)
    )
  noticia.save
end

CSV.foreach('./db/results.csv', CSV_OPTIONS) do |row|
  result = Result.new(
    date_time: row[0],
    competition_id: row[1],
    home_club_goals: row[2]
    away_club_goals: row[3],
    home_club_id: row[4].to_i,
    home_club_id: row[5].to_i
    )
  resutl.save
end
