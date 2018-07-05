class AddBruteForceProtectionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :failed_logins_count, :integer,  :default => 0,   comment: 'ログイン失敗回数'
    add_column :users, :lock_expires_at,     :datetime, :default => nil, comment: 'アカウントロック有効期限'
    add_column :users, :unlock_token,        :string,   :default => nil, comment: 'アンロックトークン'
  end
end
