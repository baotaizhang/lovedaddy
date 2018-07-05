class Area < ActiveHash::Base
  include ActiveHash::Associations
  has_many :prefectures

  self.data = [
    { id: 1, name: '北海道', name_english: 'hokkaido' },
    { id: 2, name: '東北', name_english: 'tohoku' },
    { id: 3, name: '関東', name_english: 'kanto' },
    { id: 4, name: '中部', name_english: 'chubu' },
    { id: 5, name: '関西', name_english: 'kansai' },
    { id: 6, name: '中国', name_english: 'chugoku' },
    { id: 7, name: '四国', name_english: 'shikoku' },
    { id: 8, name: '九州', name_english: 'kyushu' },
    { id: 9, name: '海外', name_english: 'oversea' }
  ]
end
