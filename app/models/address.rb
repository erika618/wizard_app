class Address < ApplicationRecord
  # 住所情報を入力した時点で外部キーがnilであってもDBに保存する
  belongs_to :user, optional: true
  validates :postal_code, :address, presence: true
end
