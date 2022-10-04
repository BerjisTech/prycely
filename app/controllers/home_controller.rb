# frozen_string_literal: true

class HomeController < ApplicationController
  UFAMI = Group.find_by(name: 'Ufami Sacco').id
  ADMIN = User.find_by(email: 'ufamisacco@gmail.com').id
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

    render json: [
      create_ufami_users(members),
      create_contributions(contributions),
      create_payment_categories(payment_categories, payments)
    ]
  end

  def create_ufami_users(members)
    members.map do |member|
      User.where(email: "#{member['name'].gsub(' ', '_').downcase}@ufamisacco.com").destroy_all
      user = User.create!({
                            email: "#{member['name'].gsub(' ', '_').downcase}@ufamisacco.com",
                            password: "Ufami_#{member['phone']}",
                            password_confirmation: "Ufami_#{member['phone']}",
                            created_at: Time.at(member['date_joined'].to_i).to_s(:db)
                          })
      add_account(user, member)
      add_member_to_ufami(user, member)
    end
  end

  def add_account(user, member)
    Account.find_or_create_by!({
                                 user_id: user.id,
                                 phone: member['phone'],
                                 first_name: member['name'].split(' ').first,
                                 last_name: member['name'].split(' ').drop(1).join(' '),
                                 photo: nil,
                                 deactivated: nil,
                                 verified: nil,
                                 country: 'KE',
                                 county: 'Nairobi',
                                 city: 'Nairobi',
                                 street: 'Nairobi',
                                 address: 'Nairobi',
                                 postal: 'Nairobi',
                                 account_type: nil,
                                 tour: nil,
                                 default_currency: 'KES',
                                 created_at: Time.at(member['date_joined'].to_i).to_s(:db)
                               })
  end

  def add_member_to_ufami(user, member)
    Member.find_or_create_by!({
                                invited_by: ADMIN,
                                user_id: user.id,
                                group_id: UFAMI,
                                designation: Designation.find_or_create_by(name: 'Member').id,
                                status: member['status'],
                                invited_on: Date.today,
                                accepted_on: Date.today,
                                paid_member: '',
                                amount: 1000,
                                account_id: Account.find_or_create_by(user_id: user.id).id,
                                member_number: member['member_id']
                              })
  end

  def create_contributions(contributions)
    contributions.map do |contribution|
      user = Member.find_by(member_number: contribution['member'].to_i).user_id
      Transaction.find_or_create_by!({
                                       user_id: user,
                                       amount: contribution['amount'].to_f * 100,
                                       transaction_reference: user,
                                       transaction_type: 1,
                                       group_id: UFAMI,
                                       wallet_id: UFAMI,
                                       status: 1,
                                       transaction_mode: 0,
                                       description: '',
                                       category: Paymentcategory.find_by(group_id: UFAMI, name: 'contribution').id,
                                       sub_category: nil,
                                       currency: 'KES',
                                       level: 1,
                                       created_at: Time.at(contribution['date'].to_i).to_s(:db),
                                       updated_at: Time.at(contribution['date'].to_i).to_s(:db)
                                     })
    end
  end

  def create_payment_categories(payment_categories, payments)
    payment_categories.map do |category|
      cat = Paymentcategory.find_or_create_by!({
                                                 group_id: UFAMI,
                                                 created_by: ADMIN,
                                                 payment_category_type: Paymentcategory.category_name.index(category['type'].downcase),
                                                 name: category['category_name']
                                               })
      create_payments(cat.id, payments.filter { |f| f['category'] == category['category_id'] })
    end
  end

  def create_payments(category, payments)
    payments.map do |payment|
      member = Member.find_by(member_number: payment['member'].to_i)
      user = member.present? ? member.user_id : ADMIN
      Transaction.find_or_create_by!({
                                       user_id: user,
                                       amount: payment['amount'].to_f * 100,
                                       transaction_reference: user,
                                       transaction_type: Paymentcategory.category_name.index(payment['type'].downcase),
                                       group_id: UFAMI,
                                       wallet_id: UFAMI,
                                       status: 1,
                                       transaction_mode: 0,
                                       description: payment['description'],
                                       category: category,
                                       sub_category: nil,
                                       currency: 'KES',
                                       level: 1,
                                       created_at: Time.at(payment['date'].to_i).to_s(:db),
                                       updated_at: Time.at(payment['date'].to_i).to_s(:db)
                                     })
    end
  end

  def about; end

  def pricing; end
end
