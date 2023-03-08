module SalesCommission
  class SalesRepresentative
    attr_reader :sales
    attr_accessor :commission

    def initialize(sales)
      @sales = sales
      @commission = 0
    end
  end
end
