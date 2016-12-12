module Api::V1
  class AddressesController < ApiController

    def index
      addresses = Address.joins(:users).group("addresses.id").having("count(users.id) > 1")
        .map do |a|  
          {
            ip: a.ip.to_s, 
            users: a.users.to_a.map {|u| u.login}
          }
        end

      render json: addresses.to_json
    end

    # def index
    #   addresses = Address.joins(:users).group("addresses.id").having("count(users.id) > 1")
    #   render json: addresses
    # end

  end
end