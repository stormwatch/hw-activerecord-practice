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

  def self.born_before_1980
    where 'birthdate < ?', '1980-01-01'
  end

  def self.with_valid_email_and_born_before_1980
    #This would work if it were not for the requisite of using ‘one or more calls to ActiveRecord's “where()”’
    # born_before_1980.with_valid_email

    # An example chaining calls to where would also work:
    # where('birthdate < ?', '1980-01-01').where('email LIKE ?', '%@%')

    # So Finally, I chose this, which works but disappoints everybody while
    # trying to please everybody:
    born_before_1980.where('email LIKE ?', '%@%')
  end

  def self.last_names_starting_with_b
    where('last LIKE ?', 'B%').order(:birthdate)
  end

  def self.twenty_youngest
    order(birthdate: :desc).limit 20
  end

  def self.update_gussie_murray_birthdate
    find_by(first: 'Gussie', last: 'Murray')
      .update birthdate: Time.parse('2004-02-08')
  end

  def self.change_all_invalid_emails_to_blank
    with_invalid_email.update_all email: ''
  end

  def self.delete_meggie_herman
    find_by(first: 'Meggie', last: 'Herman').destroy
  end
end
