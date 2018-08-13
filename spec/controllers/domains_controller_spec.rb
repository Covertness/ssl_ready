require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
  let!(:domains) { create_list(:domain, 10) }
  let(:first_domain) { domains.first }

  describe 'GET /domains' do
    before { get :index }

    it 'returns domains' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /domains/:id' do
    context 'when the record exists' do
      before { get :show, params: { id: first_domain.id }, format: :json }

      it 'returns the domain' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(first_domain.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get :show, params: { id: 10_000_000 }, format: :json }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /domains' do
    let(:valid_params) { { source_host: 'test.com', dest_host: 'test2.com' } }

    context 'when the source domain is valid' do
      before { post :create, params: valid_params, format: :json }

      it 'creates a domain' do
        expect(json['status']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'domain has flux' do
        expect(Domain.find_by(source_host: 'test.com').flux).to be_present
      end
    end

    context 'when the source domain has existed' do
      let(:existed_domain) { first_domain.source_host }

      it 'returns status code 409' do
        post :create, params: { source_host: existed_domain }, format: :json
        expect(response).to have_http_status(409)
      end
    end
  end

  describe 'PUT /domains/:id' do
    let(:valid_params) { { id: first_domain.id, dest_host: 'test3.com' } }

    context 'when the record exists' do
      before { put :update, params: valid_params, format: :json }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /domains/:id' do
    before { delete :destroy, params: { id: first_domain.id }, format: :json }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
