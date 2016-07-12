class ApexDomain
  def self.matches?(request)
    case request.subdomain
    when "www", "", nil
      true
    else
      false
    end
  end
end

class Subdomain
  def self.matches?(request)
    case request.subdomain
    when "www", "", nil
      false
    else
      true
    end
  end
end
