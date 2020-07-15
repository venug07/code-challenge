class Company < ApplicationRecord
  has_rich_text :description

  validate :email_domain

  before_save :set_city_and_state, if: :zip_code_changed?



  def email_domain
     errors.add(:email, "Domain name is not valid") if email.present? && email.split("@").last != "getmainstreet.com"
  end

  def set_city_and_state
  	if self.zip_code.present?
     city_detail = ZipCodes.identify(self.zip_code) 
     self.state = city_detail[:state_name]
     self.state_code = city_detail[:state_code]
     self.city = city_detail[:city]
    end 
  end 	


end
