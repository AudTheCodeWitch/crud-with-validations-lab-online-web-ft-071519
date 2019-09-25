class Song < ApplicationRecord
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, numericality: { less_than_or_equal_to: DateTime.now.year }, if: :is_released?
  validates :artist_name, presence: true
  validate :duplicate_song?

  def is_released?
    released == true
  end

  def duplicate_song?
    if Song.find_by(title: title, release_year: release_year, artist_name: artist_name)
      errors.add(:title, "duplicate title")
    end
  end

end
