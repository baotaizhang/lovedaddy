class Prefecture < ActiveHash::Base
  include ActiveHash::Associations
  has_many :residence_users,  class_name: 'User', foreign_key: :residence
  has_many :birthplace_users, class_name: 'User', foreign_key: :birthplace
  belongs_to :area

  self.data = [
    { id: 1, area_id: 1, name: '北海道', name_english: 'hokkaido' },
    { id: 2, area_id: 2, name: '青森県', name_english: 'aomori' },
    { id: 3, area_id: 2, name: '岩手県', name_english: 'iwate' },
    { id: 4, area_id: 2, name: '宮城県', name_english: 'miyagi' },
    { id: 5, area_id: 2, name: '秋田県', name_english: 'akita' },
    { id: 6, area_id: 2, name: '山形県', name_english: 'yamagata' },
    { id: 7, area_id: 2, name: '福島県', name_english: 'fukushima' },
    { id: 8, area_id: 3, name: '茨城県', name_english: 'ibaraki' },
    { id: 9, area_id: 3, name: '栃木県', name_english: 'tochigi' },
    { id: 10, area_id: 3, name: '群馬県', name_english: 'gunma' },
    { id: 11, area_id: 3, name: '埼玉県', name_english: 'saitama' },
    { id: 12, area_id: 3, name: '千葉県', name_english: 'chiba' },
    { id: 13, area_id: 3, name: '東京都', name_english: 'tokyo' },
    { id: 14, area_id: 3, name: '神奈川県', name_english: 'kanagawa' },
    { id: 15, area_id: 4, name: '新潟県', name_english: 'nigata' },
    { id: 16, area_id: 4, name: '富山県', name_english: 'toyama' },
    { id: 17, area_id: 4, name: '石川県', name_english: 'ishikawa' },
    { id: 18, area_id: 4, name: '福井県', name_english: 'fukui' },
    { id: 19, area_id: 4, name: '山梨県', name_english: 'yamanashi' },
    { id: 20, area_id: 4, name: '長野県', name_english: 'nagano' },
    { id: 21, area_id: 4, name: '岐阜県', name_english: 'gifu' },
    { id: 22, area_id: 4, name: '静岡県', name_english: 'shizuoka' },
    { id: 23, area_id: 4, name: '愛知県', name_english: 'aichi' },
    { id: 24, area_id: 5, name: '三重県', name_english: 'mie' },
    { id: 25, area_id: 5, name: '滋賀県', name_english: 'shiga' },
    { id: 26, area_id: 5, name: '京都府', name_english: 'kyoto' },
    { id: 27, area_id: 5, name: '大阪府', name_english: 'osaka' },
    { id: 28, area_id: 5, name: '兵庫県', name_english: 'hyogo' },
    { id: 29, area_id: 5, name: '奈良県', name_english: 'nara' },
    { id: 30, area_id: 5, name: '和歌山県', name_english: 'wakayama' },
    { id: 31, area_id: 6, name: '鳥取県', name_english: 'tottori' },
    { id: 32, area_id: 6, name: '島根県', name_english: 'shimane' },
    { id: 33, area_id: 6, name: '岡山県', name_english: 'okayama' },
    { id: 34, area_id: 6, name: '広島県', name_english: 'hiroshima' },
    { id: 35, area_id: 6, name: '山口県', name_english: 'yamaguchi' },
    { id: 36, area_id: 7, name: '徳島県', name_english: 'tokushima' },
    { id: 37, area_id: 7, name: '香川県', name_english: 'kagawa' },
    { id: 38, area_id: 7, name: '愛媛県', name_english: 'ehime' },
    { id: 39, area_id: 7, name: '高知県', name_english: 'kochi' },
    { id: 40, area_id: 8, name: '福岡県', name_english: 'fukuoka' },
    { id: 41, area_id: 8, name: '佐賀県', name_english: 'saga' },
    { id: 42, area_id: 8, name: '長崎県', name_english: 'nagasaki' },
    { id: 43, area_id: 8, name: '熊本県', name_english: 'kumamoto' },
    { id: 44, area_id: 8, name: '大分県', name_english: 'oita' },
    { id: 45, area_id: 8, name: '宮崎県', name_english: 'miyazaki' },
    { id: 46, area_id: 8, name: '鹿児島県', name_english: 'kagoshima' },
    { id: 47, area_id: 8, name: '沖縄県', name_english: 'okinawa' },
    { id: 48, area_id: 9, name: '海外', name_english: 'oversea' }
  ]

  def area
    Area.find(area_id)
  end

  # 4都道府県に限定した検索レコード
  def self.restricted_area
    self.where(id: [13, 14, 12, 11])
  end
end
