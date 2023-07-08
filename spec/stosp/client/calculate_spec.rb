# frozen_string_literal: true

RSpec.describe Stosp::Client::Calculate, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#calculate' do
    context 'with successfully' do
      let(:response_body) do
        {
          price: 100,
          tariffName: 'Tariff',
          deliveryPeriod: '2',
          error: ''
        }.to_json
      end
      let(:request_body) do
        {
          fromCityId: 1,
          fromCity: 'Khv',
          toCityId: 2,
          toCity: 'Vdk',
          weight: 1.0,
          volume: 1.0
        }
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/api/distributor/delivery/calculate')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with empty error' do
        expect(client.calculate(request_body)['error']).to be_empty
      end
    end

    context 'with error' do
      let(:response_body) do
        {
          price: 100,
          tariffName: 'Tariff',
          deliveryPeriod: '2',
          error: 'Error'
        }.to_json
      end
      let(:request_body) do
        {
          fromCityId: 1,
          fromCity: 'Khv',
          toCityId: 2,
          toCity: 'Vdk',
          weight: 1.0,
          volume: 1.0
        }
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/api/distributor/delivery/calculate')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.calculate(request_body) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
