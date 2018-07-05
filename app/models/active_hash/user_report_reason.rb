class UserReportReason < ActiveHash::Base
  include ActiveHash::Associations
  has_many :report, class_name: 'UserReport', foreign_key: :reason_id

  self.data = [
    { id:  1, title: '他サイトやビジネスへの勧誘' },
    { id:  2, title: '詐欺行為' },
    { id:  3, title: '商売利用目的' },
    { id:  4, title: 'プロフィール項目の詐称' },
    { id:  5, title: '偽アカウント' },
    { id:  6, title: '不適切な登録内容' },
    { id:  7, title: '無断のドタキャン' },
    { id:  8, title: 'メッセージが攻撃的' },
    { id:  9, title: 'ストーカー行為' },
    { id: 10, title: '卑猥な言動' },
    { id: 11, title: '個人情報交換後に連絡が途絶えた' },
    { id: 12, title: '窃盗行為' },
    { id: 99, title: 'その他' }
  ]
end
