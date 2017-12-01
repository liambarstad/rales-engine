# Rails Engine

###Setup

First, clone the repo and do a bundle install. Rales Engine uses ruby version 2.4.1, so make sure you have 2.4.1 installed.

    $ git clone git@github.com:liambarstad/rales-engine.git
    $ bundle install
    
Next, initialize the database, run the migrations, and seed the database.

    $ rake db:{create,migrate}
    $ rake import_csv:all

If postgres is non-responsive on your machine, try opening a separate terminal and starting it manually by:

    $ pg_ctl -D /usr/local/var/postgres start

To run the app on a local server,

    $ rails s

This will run the app on port 3000 to the url 'http://localhost:3000'

##Features

Rales Engine is a fully accessible API that outputs data, relationships, and business intelligence pertaining to:

* Invoices
  * status
  * merchant id
  * customer id
  * created at
  * updated at

* Invoice Items
  * quantity
  * unit price
  * item id
  * invoice id
  * created at
  * updated at

* Items
  * name
  * unit price
  * description
  * merchant id
  * created at
  * updated at

* Merchants
  * name
  * created at
  * updated at

* Customers
  * first name
  * last name
  * created at
  * updated at

* Transactions
  * result
  * credit card number
  * credit card expiration date
  * invoice id
  * created at
  * updated at

All endpoints should be preceeded with either 'http://localhost:3000', or the url or port the app is running on. When finding a record by parameters, use the attribute names listed above separated by an underscore.
The endpoints are listed here:

###Invoices

* All invoices: *GET '/api/v1/invoices*
* Find specific invoice: *GET '/api/v1/invoices/:id*
* Find invoice by parameters: *GET '/api/v1/invoices/find?parameters*
* Find all invoices with parameters: *GET '/api/v1/invoices/find_all?parameters*
* Find a random invoice: *GET '/api/v1/invoices/random'*
* Find all transactions a specific invoice: *GET '/api/v1/invoices/:id/transactions'*
* Find all invoice items for a specific invoice: *GET /api/v1/invoices/:id/invoice_items*
* Find all items for a specific invoice: *GET /api/v1/invoices/:id/items*
* Find the customer for a specific invoice: *GET /api/v1/invoices/:id/customer*
* Find the merchant for a specific invoice: *GET /api/v1/invoices/:id/merchant*

###Items

* All items: *GET '/api/v1/items*
* Find specific item: *GET '/api/v1/items/:id'*
* Find item by parameters: *GET '/api/v1/items/find?parameters*
* Find all items by parameters: *GET '/api/v1/items/find_all?parameters*
* Find a random item: *GET '/api/v1/items/random*
* Find all invoice items for a specific item: *GET /api/v1/items/:id/invoice_items*
* Find the merchant for a specific item: *GET /api/v1/items/:id/merchant*

###Invoice Items

* All invoice items: *GET '/api/v1/invoice_items*
* Find specific invoice item: *GET '/api/v1/invoice_items/:id*
* Find invoice item by parameters: *GET '/api/v1/invoice_items/find?parameters*
* Find all invoice items by parameters: *GET '/api/v1/invoice_items/find?parameters*
* Find a random invoice item: *GET '/api/v1/invoice_items/find_all?parameters*
* Find the invoice for a specific invoice item: *GET /api/v1/invoice_items/:id/invoice*
* Find the item for a specific invoice item: *GET /api/v1/invoice_items/:id/item*

###Merchants

* All merchants: *GET '/api/v1/merchants*
* Find specific merchant: *GET '/api/v1/merchants/:id*
* Find merchant by parameters: *GET '/api/v1/merchants/find?parameters*
* Find all merchants by parameters: *GET '/api/v1/merchants/find?parameters*
* Find a random merchant: *GET '/api/v1/merchants/find_all?parameters*
* Find the items for a specific merchant: *GET /api/v1/merchants/:id/items*
* Find the invoices for a specific merchant: *GET /api/v1/merchants/:id/invoices*

###Customers

* All customers: *GET '/api/v1/customers*
* Find specific customers: *GET '/api/v1/customers/:id*
* Find customer by parameters: *GET '/api/v1/customers/find?parameters*
* Find all customers by parameters: *GET '/api/v1/customers/find?parameters*
* Find a random customer: *GET '/api/v1/customers/find_all?parameters*
* Find the items for a specific customer: *GET /api/v1/customer/:id/items*
* Find the invoices for a specific customer: *GET /api/v1/customers/:id/invoices*
* Find the transactions for a specific customer: *GET /api/v1/customers/:id/transactions*

###Transactions

* All transactions: *GET '/api/v1/transactions*
* Find specific transaction: *GET '/api/v1/transactions/:id*
* Find transaction by parameters: *GET '/api/v1/transactions/find?parameters*
* Find all transactions by parameters: *GET '/api/v1/transactions/find?parameters*
* Find a random transaction: *GET '/api/v1/transactions/find_all?parameters*
* Find the invoice for a specific transactions: *GET /api/v1/transaction/:id/invoice*

##Business Intelligence

* *GET /api/v1/merchants/most_revenue?quantity=x* returns the top x merchants ranked by total revenue.
* *GET /api/v1/merchants/most_items?quantity=x* returns the top x merchants ranked by total number of items sold.
* *GET /api/v1/merchants/revenue?date=x* returns the total revenue for date x across all merchants.
* *GET /api/v1/merchants/:id/revenue* returns the total revenue for that merchant across successful transactions.
* *GET /api/v1/merchants/:id/revenue?date=x* returns the total revenue for that merchant for a specific invoice date x.
* *GET /api/v1/merchants/:id/favorite_customer* returns the customer who has conducted the most total number of successful transactions.
* *GET /api/v1/merchants/:id/customers_with_pending_invoices* returns a collection of customers which have pending (unpaid) invoices.
* *GET /api/v1/items/most_revenue?quantity=x* returns the top x items ranked by total revenue generated.
* *GET /api/v1/items/most_items?quantity=x* returns the top x item instances ranked by total number sold.
* *GET /api/v1/items/:id/best_day* returns the date with the most sales for the given item using the invoice date.
* *GET /api/v1/customers/:id/favorite_merchant* returns a merchant where the customer has conducted the most successful transactions.

##Testing

Rales Engine is fully tested in RSpec, the contents of which can be found in the /spec directory folder. It is also tested using an external testing suite written in unittest which can be found [here]("https://github.com/turingschool/rales_engine_spec_harness")

In order to run the external test suite, clone the repo listed above and open it in a separate terminal tab. Then run Rails Engine using *$ rails s* and navigate back to the tab where the spec harness is open and run:

    rake                          #runs all tests
    ruby test/<< directory name   #runs a specific test file

####credits: Marshall Houston and Liam Barstad
