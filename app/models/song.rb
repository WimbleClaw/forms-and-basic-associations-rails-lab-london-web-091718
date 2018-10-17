class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes



  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end


  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def note_contents
    self.notes.map {|note| note.content}
  end

  def note_contents=(contents)

    contents.select! { |note_contents| note_contents.length >= 1}
    self.notes += contents.map do |note_contents|
    Note.create(content: note_contents, song: self)
    # self.notes += contents.map do |note_contents|
    # Note.find_or_create_by(content: note_contents)
    end
  end

end
