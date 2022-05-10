# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end
  
  def ufami
    json_from_file = File.read(File.join(File.dirname(__FILE__), '../beshesha/ufami.json'))
    hash = JSON.parse(json_from_file)

    old_tables = hash.group_by { |g| g['name'] }.keys.drop(2)

    admin = hash.filter { |f| f['name'] == 'admin' }.first['data']
    members = hash.filter { |f| f['name'] == 'members' }.first['data']
    contributions = hash.filter { |f| f['name'] == 'contributions' }.first['data']

    loans = hash.filter { |f| f['name'] == 'loans' }.first['data']
    loan_category = hash.filter { |f| f['name'] == 'loan_category' }.first['data']
    loan_payments = hash.filter { |f| f['name'] == 'loan_payments' }.first['data']

    payments = hash.filter { |f| f['name'] == 'payments' }.first['data']
    payment_categories = hash.filter { |f| f['name'] == 'payment_categories' }.first['data']

    payroll = hash.filter { |f| f['name'] == 'payroll' }.first['data']
    create_ufami_users(members)
    create_contributions(contributions)
  end

  def create_ufami_users(members)
    members.map do |member|
      user = User.create!({
                            email: "#{member['name'].gsub(' ', '_').downcase}@ufamisacco.com",
                            password: member['phone'],
                            password_confirmation: member['phone']
                          })
      add_account(user, member)
      add_member_to_ufami(user, member)
    end
  end

  def add_account(user, member)
    Account.create!({
                      user_id: user.id,
                      phone: member['phone'],
                      first_name: member['name'].split(' ').first,
                      last_name: member['name'].split(' ').drop(1).join(' '),
                      photo: null,
                      deactivated: null,
                      verified: null,
                      country: 'KE',
                      county: 'Nairobi',
                      city: 'Nairobi',
                      street: 'Nairobi',
                      address: 'Nairobi',
                      postal: 'Nairobi',
                      account_type: null,
                      tour: null,
                      default_currency: 'KES'
                    })
  end

  def add_member_to_ufami(user, _member_number)
    Member.create!({
                     invited_by: User.find_by(email: 'ufamisacco@gmail.com').id,
                     user_id: user.id,
                     group_id: Group.find_by(name: 'Ufami Sacco').id,
                     designation: Designation.find_or_create_by(name: 'Member').id,
                     status: member['status'],
                     invited_on: Date.today,
                     accepted_on: Date.today,
                     paid_member: '',
                     amount: 1000,
                     account_id: Account.find_or_create_by(user_id: user.id),
                     member_number: member['member_id']
                   })
  end

  def create_contributions(contributions)
    contributions.map do |contribution|
      Transaction.create!({
                            user_id: Member.find_by(member_number: contribution['member'].to_i),
                            amount: contribution['amount'],
                            transaction_reference: user.id,
                            transaction_type: 1,
                            group_id: Group.find_by(name: 'Ufami Sacco').id,
                            wallet_id: Group.find_by(name: 'Ufami Sacco').id,
                            status: 1,
                            transaction_mode: 0,
                            description: '',
                            category: null,
                            sub_category: null,
                            currency: 'KES',
                            level: 1
                          })
    end
  end

  def about; end

  def pricing; end
end
