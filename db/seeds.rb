require 'csv'
require 'byebug'

User.destroy_all
Player.destroy_all
Club.destroy_all
Competition.destroy_all
MarketValue.destroy_all
New.destroy_all
Result.destroy_all
Stat.destroy_all
Token.destroy_all
Transaction.destroy_all

CSV_OPTIONS = {
  col_sep: ';',
  quote_char: '"',
  headers: :first_row,
  header_converters: :symbol
}

CSV.foreach('./db/users.csv', CSV_OPTIONS) do |row|
  user = User.new(
    email: row[0],
    password: row[1],
    address: row[2],
    postcode: row[3],
    birthday: row[4],
    first_name: row[5],
    last_name: row[6]
    )
  user.save
end

CSV.foreach('./db/clubs.csv', CSV_OPTIONS) do |row|
  club = Club.new(
    name: row[0],
    logo: row[1],
    city: row[2]
    )
  club.save
end

CSV.foreach('./db/players.csv', CSV_OPTIONS) do |row|
  player = Player.new(
    name: row[0],
    photo: row[1],
    age: row[2],
    height: row[3],
    nationality: row[4],
    club_id: row[5],
    position: row[6],
    social_url: row[7]
    )
  player.save
end

CSV.foreach('./db/competitions.csv', CSV_OPTIONS) do |row|
  competition = Competition.new(
    name: row[0],
    logo: row[1]
    )
  competition.save
end

CSV.foreach('./db/results.csv', CSV_OPTIONS) do |row|
  result = Result.new(
    date_time: row[0],
    competition_id: row[1],
    home_club_goals: row[2],
    away_club_goals: row[3],
    home_club_id: row[4].to_i,
    away_club_id: row[5].to_i
    )
  result.save
end

CSV.foreach('./db/stats.csv', CSV_OPTIONS) do |row|
  stat = Stat.new(
    player_id: row[0],
    competition_id: row[1],
    games: row[2],
    goals: row[3],
    assists: row[4],
    form: row[5]
    )
  stat.save
end

CSV.foreach('./db/news.csv', CSV_OPTIONS) do |row|
  noticia = New.new(
    date_time: row[0],
    tag: row[1],
    title: row[2],
    summary: row[3],
    content: row[4],
    club: Club.find(row[5].to_i),
    player: Player.find(row[6].to_i)
    )
  noticia.save
end

CSV.foreach('./db/market_values.csv', CSV_OPTIONS) do |row|
  market = MarketValue.new(
    player_id: row[0],
    date_time: row[1],
    market_value: row[2]
    )
  market.save
end

CSV.foreach('./db/tokens.csv', CSV_OPTIONS) do |row|

  token = Token.new(
    on_sale: row[0] == "TRUE",
    last_price: row[1],
    player_id: row[2],
    owner: row[3]
    )
  # puts "-- #{token}"
  # puts "INV #{token.errors.messages}" unless token.valid?

  token.save
end

CSV.foreach('./db/transactions.csv', CSV_OPTIONS) do |row|
  transaction = Transaction.new(
    date_time: row[0],
    price: row[1],
    token_id: row[2],
    buying_user_id: row[3],
    selling_user_id: row[4]
    )
  transaction.save
end
