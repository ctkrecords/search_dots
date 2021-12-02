class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :firstname, :lastname, :country_id, :email, :password, :password_confirmation, :remember_me, :admin_type_id, :company_id
  #attr_accessible :title, :body

  belongs_to :country
  belongs_to :admin_type
  belongs_to :company

  def fullname
  	self.firstname+' '+self.lastname
  end

  def is_root
    if self.admin_type_id==1
      return true 
    else
      return false
    end
  end

  def is_company_admin
    if self.admin_type_id==2
      return true 
    else
      return false
    end
  end

  def is_country_admin
    if self.admin_type_id==3
      return true 
    else
      return false
    end
  end
end

# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  firstname              :string(255)
#  lastname               :string(255)
#  country_id             :integer
#  admin_type_id          :integer
#  is_deleted             :boolean          default(FALSE)
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#  is_verified            :boolean          default(FALSE)
#  token                  :string(255)
#  is_active              :boolean          default(FALSE)
#  photo                  :string(255)
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
