require_relative '../../lib/sales_commission/calculator'

RSpec.describe SalesCommission::Calculator do
  let(:sales_representatives) do
    [
      SalesCommission::SalesRepresentative.new(5_000),
      SalesCommission::SalesRepresentative.new(15_000),
      SalesCommission::SalesRepresentative.new(25_000),
    ]
  end

  context "when total sales is less than 100,000" do
    let(:calculator) { SalesCommission::Calculator.new(50_000, sales_representatives) }

    it "calculates the correct commission for each sales representative" do
      calculator.calculate_commissions
      expect(sales_representatives[0].commission).to eq(750.0)
      expect(sales_representatives[1].commission).to eq(2_625.0)
      expect(sales_representatives[2].commission).to eq(5_000.0)
    end
  end

  context "when total sales is between 100,000 and 200,000" do
    let(:calculator) { SalesCommission::Calculator.new(150_000, sales_representatives) }

    it "calculates the correct commission for each sales representative" do
      calculator.calculate_commissions
      expect(sales_representatives[0].commission).to eq(1_000.0)
      expect(sales_representatives[1].commission).to eq(3_375.0)
      expect(sales_representatives[2].commission).to eq(6_250.0)
    end
  end

  context "when total sales is greater than 200,000" do
    let(:calculator) { SalesCommission::Calculator.new(250_000, sales_representatives) }

    it "calculates the correct commission for each sales representative" do
      calculator.calculate_commissions
      expect(sales_representatives[0].commission).to eq(1_250.0)
      expect(sales_representatives[1].commission).to eq(4_125.0)
      expect(sales_representatives[2].commission).to eq(7_500.0)
    end
  end

  context "when passing individual_rates as params" do
    let(:individual_rates) {
      {
        (0..999.99) => 0.05,
        (1_000..1_999.99) => 0.075,
        (2_000..Float::INFINITY) => 0.1,
      }
    }
    let(:calculator) { SalesCommission::Calculator.new(250_000, sales_representatives, individual_rates: individual_rates) }

    it "calculates the correct commission for each sales representative" do
      calculator.calculate_commissions
      expect(sales_representatives[0].commission).to eq(1_500.0)
      expect(sales_representatives[1].commission).to eq(4_500.0)
      expect(sales_representatives[2].commission).to eq(7_500.0)
    end
  end

  context "when passing team_rates as params" do
    let(:team_rates) {
      {
        (0..9_999.99) => 0.1,
        (10_000..59_999.99) => 0.15,
        (60_000..Float::INFINITY) => 0.2,
      }
    }
    let(:calculator) { SalesCommission::Calculator.new(50_000, sales_representatives, team_rates: team_rates) }

    it "calculates the correct commission for each sales representative" do
      calculator.calculate_commissions
      expect(sales_representatives[0].commission).to eq(1_000.0)
      expect(sales_representatives[1].commission).to eq(3_375.0)
      expect(sales_representatives[2].commission).to eq(6_250.0)
    end
  end


  context "when passing personalized_equation as params" do
    context "and personalized_equation is valid" do
      let(:personalized_equation) { "individual_sales * individual_rate * team_rate" }
      let(:calculator) { SalesCommission::Calculator.new(50_000, sales_representatives, personalized_equation: personalized_equation) }

      it "calculates the correct commission for each sales representative" do
        calculator.calculate_commissions
        expect(sales_representatives[0].commission).to eq(25.0)
        expect(sales_representatives[1].commission).to eq(112.5)
        expect(sales_representatives[2].commission).to eq(250.0)
      end
    end

    context "and personalized_equation is invalid" do
      let(:personalized_equation) { "individual_sales * individual_rate * team_rate * variable_not_exist" }
      let(:calculator) { SalesCommission::Calculator.new(50_000, sales_representatives, personalized_equation: personalized_equation) }

      it "calculates the correct commission for each sales representative" do
        expect { calculator.calculate_commissions }.to raise_error(ArgumentError)
      end
    end
  end
end
