require 'pry'

class MusicLibraryController

  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(@path).import
  end

  def call
    user_input = nil
    until user_input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.chomp
    end
  end

  def list_songs
    counter = 1
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end
  end

  def list_artists
    counter = 1
    sorted_artists = Artist.all.sort_by {|artist| artist.name}
    sorted_artists.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1
    end
  end

  def list_genres
    counter = 1
    sorted_genres = Genre.all.sort_by {|genre| genre.name}
    sorted_genres.each do |genre|
      puts "#{counter}. #{genre.name}"
      counter += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_search = gets.chomp
    artist = Artist.find_by_name(artist_search)
    if Artist.find_by_name(artist_search)
      artist = Artist.find_by_name(artist_search)
      sorted_songs = artist.songs.sort_by {|song| song.name}
      counter = 1
      sorted_songs.each do |song|
        puts "#{counter}. #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_search = gets.chomp
    genre = Genre.find_by_name(genre_search)
    if Genre.find_by_name(genre_search)
      genre = Genre.find_by_name(genre_search)
      sorted_songs = genre.songs.sort_by {|song| song.name}
      counter = 1
      sorted_songs.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name}"
        counter += 1
      end
    end
  end

  def play_song
    list_songs
    puts "Which song number would you like to play?"
  end

end
