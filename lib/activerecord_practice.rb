require 'sqlite3'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.

  def self.any_candice
    # YOUR CODE HERE to return all customer(s) whose first name is Candice
    # probably something like:  Customer.where(....)
    where first: 'Candice'
  end

  def self.with_valid_email
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
    where 'email LIKE ?', '%@%'
  end

  def self.with_dot_org_email
    where 'email LIKE ?', '%.org'
  end

  def self.with_invalid_email
    where 'email NOT LIKE ?', '%@%'
  end

  def self.with_blank_email
    where email: nil
  end
end
