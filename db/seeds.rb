require 'csv'

User.destroy_all
Club.destroy_all
Competition.destroy_all
Market_value.destroy_all
New.destroy_all
Player.destroy_all
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

CSV.foreach('./db/stats.csv', CSV_OPTIONS) do |row|
  stat = Stat.new(
    player_id: row[0],
    competition: row[1],
    games: row[2],
    goals: row[3],
    assists: row[4],
    form: row[5]
    )
  stat.save
end

CSV.foreach('./db/market_values.csv', CSV_OPTIONS) do |row|
  market_value = MarketValue.new(
    player_id: row[0],
    date_time: row[1],
    market_value: row[2]
    )
  market_value.save
end

CSV.foreach('./db/tokens.csv', CSV_OPTIONS) do |row|
  token = Token.new(
    on_sale?: row[0],
    last_price: row[1],
    player_id: row[2],
    owner: row[3]
    )
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
