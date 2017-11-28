namespace :import_csv do
  require 'csv'

  task transactions: :environment do
    CSV.foreach("#{Rails.root}/db/csv/transactions.csv", headers: true) do |row|
      transaction = Transaction.create!(row.to_hash)
      puts "transaction #{transaction.id} created"
    end
  end

  task customers: :environment do
    CSV.foreach("#{Rails.root}/db/csv/customers.csv", headers: true) do |row|
      customer = Customer.create!(row.to_hash)
      puts "customer #{customer.id} created"
    end
  end

  task merchants: :environment do
    CSV.foreach("#{Rails.root}/db/csv/merchants.csv", headers: true) do |row|
      merchant = Merchant.create!(row.to_hash)
      puts "merchant #{merchant.id} created"
    end
  end

  task invoices: :environment do
    CSV.foreach("#{Rails.root}/db/csv/invoices.csv", headers: true) do |row|
      invoice = Invoice.create!(row.to_hash)
      puts "invoice #{invoice.id} created"
    end
  end

  task items: :environment do
    CSV.foreach("#{Rails.root}/db/csv/items.csv", headers: true) do |row|
      item = Item.create!(row.to_hash)
      puts "item #{item.id} created"
    end
  end

  task invoice_items: :environment do
    CSV.foreach("#{Rails.root}/db/csv/invoice_items.csv", headers: true) do |row|
      invoice_item = InvoiceItem.create!(row.to_hash)
      puts "invoice item #{invoice_item.id} created"
    end
  end

  task all: [:merchants, :items, :customers, :invoices, :invoice_items, :transactions]
end
