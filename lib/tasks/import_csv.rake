namespace :import_csv do
  require 'csv'

  task invoices: :environment do
    CSV.foreach("#{Rails.root}/db/csv/invoices.csv", headers: true) do |row|
      Invoice.create(row.to_hash)
    end
  end

  task items: :environment do
    CSV.foreach("#{Rails.root}/db/csv/items.csv", headers: true) do |row|
      Item.create(row.to_hash)
    end
  end

  task invoice_items: :environment do
    CSV.foreach("#{Rails.root}/db/csv/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create(row.to_hash)
    end
  end

  task merchants: :environment do
    CSV.foreach("#{Rails.root}/db/csv/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    CSV.foreach("#{Rails.root}/db/csv/merchants.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end

end
