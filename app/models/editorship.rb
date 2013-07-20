class Editorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :person
  # attr_accessible :title, :body
end
