class Invite < ActiveRecord::Base
  include EmailSanitizableConcern

  belongs_to :dossier
  belongs_to :user

  before_validation -> { sanitize_email(:email) }

  validates_presence_of :email
  validates_uniqueness_of :email, :scope => :dossier_id
  validates :email, format: { with: Devise.email_regexp, message: "n'est pas valide" }, allow_nil: true
end
