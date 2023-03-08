require_relative "../../lib/sales_commission/calculator"

RSpec.describe SalesCommission::PersonalizedEquation do
  let(:sales_representative) { SalesCommission::SalesRepresentative.new(15_000) }

  context "#calculate_equation" do
    context "when equation is valid" do 
      let(:personalized_equation) {
        SalesCommission::PersonalizedEquation.new(
          "individual_sales * individual_rate + individual_sales * team_rate",
          sales_representative,
          0.1,
          0.2,
          200_000
        )
      }
  
      it "calculates the correct commission for the sales representative" do
        expect(personalized_equation.calculate_equation).to eq(4500.0)
      end
    end

    context "when equation is invalid" do 
      let(:personalized_equation) {
        SalesCommission::PersonalizedEquation.new(
          "individual_sales * individual_rate + individual_sales * team_rate + x",
          sales_representative,
          0.1,
          0.2,
          200_000
        )
      }
  
      it "raise a error with the missing parameter" do
        expect { personalized_equation.calculate_equation }.to raise_error(ArgumentError)
      end
    end
    
  end
end
