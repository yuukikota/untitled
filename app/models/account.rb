class Account < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, :authentication_keys => [:login]

  attr_accessor :login

  before_save { self.acc_id = acc_id.downcase }
  validates :acc_id       , presence: true, length: { maximum: 20}, format:{with: /\A\w+\z/i}, uniqueness: { case_sensitive: false }
  validates :name         , presence: true, length: { maximum: 20}
  validates :university   , presence: true, length: { maximum: 20}
  validates :faculty      , presence: true, length: { maximum: 20}
  validates :department   , presence: true, length: { maximum: 20}
  validates :grade        , presence: true, length: { maximum: 5}
  validates :introduction , length: { maximum: 1000}

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["acc_id = :value OR email = :value", { :value => login }]).first
    else
      where(conditions).first
    end
  end
end
