class ForumThread < ApplicationRecord
  extend FriendlyId #buat slug
  friendly_id :title, use: :slugged

  belongs_to :user #karena user memiliki forum_thread dan forum thread dimiliki oleh user
  #dependent: :destroy artinya kalo kita menghapus forumthread otomatis forum_posts yg dimiliki forumthread akan dihapus juga
  has_many :forum_posts, dependent: :destroy 

  validates :title, presence: true, length: {maximum: 50} 
  validates :content, presence: true

  #? apakah dia sticky atau bukan
  def sticky?
    sticky_order != 100
  end

  #logic misal kalo sudah ada 1 maka kita akan buat 2 dan seterusnya
  #buat sederhana dulu 1 aja
  def pinit!
    self.sticky_order = 1
    self.save
  end

end
