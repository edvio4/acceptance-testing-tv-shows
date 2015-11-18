require 'csv'

CSV.open('television-shows.csv', 'a') do |file|
  title = "Friends"
  network = "NBC"
  starting_year = "1994"
  synopsis = "Six friends living in New York city"
  genre = "Comedy"
  data = [title, network, starting_year, synopsis, genre]
  file.puts(data)
end

tv_shows = []
  CSV.foreach("television-shows.csv", headers: true) do |tv_show|
    tv_shows << tv_show
end

puts tv_shows
