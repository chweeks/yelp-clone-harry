class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true

  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :restrict_with_exception,
    dependent: :destroy

end
