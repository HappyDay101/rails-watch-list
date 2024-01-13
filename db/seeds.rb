# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'uri'
require 'net/http'
require 'json'

url = URI("https://tmdb.lewagon.com/movie/top_rated")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true


request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'

response = http.request(request)
data = JSON.parse(response.read_body)

data['results'].each do |movie_data|
  Movie.create(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )
end
