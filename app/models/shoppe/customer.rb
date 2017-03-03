module Shoppe
  class Customer < ApplicationRecord
    PHONE_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

    self.table_name = 'shoppe_customers'

    has_many :addresses, inverse_of: :customer, dependent: :restrict_with_exception, class_name: 'Shoppe::Address'

    has_many :orders, dependent: :restrict_with_exception, class_name: 'Shoppe::Order'

    # Validations
    validates :phone, presence: true, format: { with: PHONE_REGEX }

    # All customers ordered by their ID desending
    scope :ordered, -> { order(id: :desc) }

    # The name of the customer in the format of "Company (First Last)" or if they don't have
    # company specified, just "First Last".
    #
    # @return [String]
    def name
      company.blank? ? full_name : "#{company} (#{full_name})"
    end

    # The full name of the customer created by concatinting the first & last name
    #
    # @return [String]
    def full_name
      "#{first_name} #{last_name}"
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w(id first_name last_name company phone) + _ransackers.keys
    end

    def self.ransackable_associations(_auth_object = nil)
      []
    end
  end
end
