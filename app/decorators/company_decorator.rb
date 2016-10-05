class CompanyDecorator < ApplicationDecorator
  delegate :name

  def header
    "#{name} blog"
  end
end
