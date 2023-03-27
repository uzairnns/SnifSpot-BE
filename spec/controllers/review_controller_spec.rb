require 'rails_helper'

RSpec.describe ReviewsController do
  describe "POST #create" do
    let(:spot) { FactoryBot.create(:spot) }

    context "with valid parameters" do
      it "creates a new review" do
        expect {
          post :create, params: { spot_id: spot.id, body: "Great spot!" }
        }.to change(Review, :count).by(1)
      end

      it "returns a successful response" do
        post :create, params: { spot_id: spot.id, body: "Great spot!" }
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid parameters" do
      it "does not create a new review" do
        expect {
          post :create, params: { spot_id: spot.id }
        }.to_not change(Review, :count)
      end

      it "returns an error response" do
        post :create, params: { spot_id: spot.id }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH #update" do
    let(:spot) { FactoryBot.create(:spot) }
    let(:review) { FactoryBot.create(:review, spot: spot) }

    context "with valid parameters" do
      it "updates the review" do
        patch :update, params: { id: review.id, body: "Updated review" }
        review.reload
        expect(review.body).to eq("Updated review")
      end

      it "returns a successful response" do
        patch :update, params: { id: review.id, body: "Updated review" }
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid parameters" do
      it "does not update the review" do
        patch :update, params: { id: review.id, body: "" }
        review.reload
        expect(review.body).to_not eq("")
      end

      it "returns an error response" do
        patch :update, params: { id: review.id, body: "" }
        expect(response).to have_http_status(422)
      end
    end
  end
end
