class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
    .select('merchants.*, sum(transactions.id) AS num_transactions')
    .joins(invoices: [:transactions, :merchant])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('num_transactions desc')
    .limit(1)
    .first
  end

  has_many :transactions, through: :invoices
end
