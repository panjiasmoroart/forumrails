class ForumPost < ApplicationRecord
  belongs_to :user
  
  #dia dimiliki oleh sebuah forum_thread
  belongs_to :forum_thread, counter_cache: true 
  
  #counter_cache digunakan untuk menghitung ada berapa post pada sebuah thread

  validates :content, presence: true
end
