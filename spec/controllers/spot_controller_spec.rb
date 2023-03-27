require 'rails_helper'

RSpec.describe SpotsController do
  let!(:spot1) { FactoryBot.create(:spot)}
  let!(:spot2) { FactoryBot.create(:spot)}
  let!(:review1) { FactoryBot.create(:review)}
  let!(:review2) { FactoryBot.create(:review)}
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status('200')
    end
    
    it "returns a list of spots with their reviews count" do
      get :index
      expect(response).to have_http_status('200')
      expect(JSON.parse(response.body)["spots"].first["spot"]["id"]).to eq(spot1.id)
    end
  end
  
  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: spot1.id }
      expect(response).to have_http_status('200')
    end
    
    it "returns the details of the spot with its reviews" do
      get :show, params: { id: spot1.id }
      expect(response).to have_http_status('200')
      expect(JSON.parse(response.body)["spot"]["id"]).to eq(spot1.id)
    end
    
    it "returns an error if the spot does not exist" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Spot not found")
    end
  end
  
  describe 'POST #create' do
    let(:valid_params) { attributes_for(:spot) }
    
    context 'when the params are valid' do
      it 'creates a new spot' do
        expect {
          post :create, params: valid_params
        }.to change(Spot, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq('Spot created successfully')
      end
    end
    
    context 'when the params are invalid' do
      it 'returns an error message' do
        valid_params[:title] = '' # make it invalid
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        response_body = JSON.parse(response.body)
        expect(response_body['message']).to eq('Spot not save')
        expect(response_body['err']).to be_present
      end
    end
  end
  
  describe '#update' do
    context 'when spot is successfully updated' do
      it 'returns a success message and status code 200' do
        patch :update, params: { id: spot1.id, title: 'Updated Spot Title'  }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Spot updated successfully')
      end
    end

    context 'when spot fails to update' do
      it 'returns an error message and status code 422' do
        patch :update, params: { id: spot1.id, title: ''}
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['message']).to eq('Spot not update')
        expect(JSON.parse(response.body)['err']).to eq("Title can't be blank")
      end
    end
    
    context 'when spot does not exist' do
      it 'returns an error message and status code 422' do
        patch :update, params: { id: -9, title: ''}
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['message']).to eq('Spot not found')
      end
    end
  end
end
