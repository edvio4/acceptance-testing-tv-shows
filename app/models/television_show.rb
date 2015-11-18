require 'pry'

class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  attr_reader :title, :network , :starting_year, :synopsis, :genre, :errors

  def initialize(tv_show={})
    @title = tv_show["title"]
    @network = tv_show["network"]
    @starting_year = tv_show["starting_year"]
    @synopsis = tv_show["synopsis"]
    @genre = tv_show["genre"]
    @errors = []
  end

  def self.all
    tv_shows = []
    CSV.foreach("television-shows.csv", headers: true) do |tv_show|
      tv_shows << tv_show
    end
    tv_shows.map { |tv_show| TelevisionShow.new(tv_show) }
  end

  def save
    if valid?
      CSV.open('television-shows.csv', 'a') do |file|
        file.puts([title, network, starting_year, synopsis, genre])
      end
      true
    else
      false
    end
  end

  def valid?
    !title.empty? &&
    !network.empty? &&
    !starting_year.empty? &&
    !synopsis.empty? &&
    !genre.empty? &&
    unique_tv_show_title
  end

  def errors?
    flag = false
    unless title.nil? || network.nil? || starting_year.nil? || synopsis.nil? || genre.nil?
      if title.empty? || network.empty? || starting_year.empty? || synopsis.empty? || genre.empty?
        @errors << "Please fill in all required fields"
        flag = true
      elsif !unique_tv_show_title
        @errors << "The show has already been added"
        flag = true
      end
    end
    flag
  end

  def unique_tv_show_title
    !TelevisionShow.all.any? { |tv_show| tv_show.title == title }
  end
end
