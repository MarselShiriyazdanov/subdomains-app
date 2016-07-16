class CompanyDecorator < ApplicationDecorator
  delegate_all

  def header
    "#{name} blog"
  end
end
