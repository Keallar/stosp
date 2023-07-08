# frozen_string_literal: true

RSpec.describe Stosp::Client::Create, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#created' do
    context 'with successfully' do
      let(:response_body) do
        {
          orderId: 123_456,
          error: '',
          orderLink: 'https://order/123456'
        }.to_json
      end
      let(:request_body) do
        {
          from: 123_456,
          didFrom: 901,
          to: 9987,
          didTo: 615_235,
          recipientLastName: 'Test',
          recipientFirstName: 'Test',
          recipientPhone: '79999999',
          estimatedCost: 1000,
          content: 'Description',
          outerOrderId: 'Not necessary',
          tariff: 'Tariff',
          length: 1.0,
          width: 1.0,
          height: 1.0,
          weigth: 1.0
        }
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/express/apiCreate')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with empty error' do
        expect(client.create(request_body)['error']).to be_empty
      end
    end

    context 'with error' do
      let(:response_body) do
        {
          orderId: 123_456,
          error: 'Error',
          orderLink: 'https://order/123456'
        }.to_json
      end
      let(:request_body) do
        {
          from: 123_456,
          didFrom: 901,
          to: 9987,
          didTo: 615_235,
          recipientLastName: 'Test',
          recipientFirstName: 'Test',
          recipientPhone: '79999999',
          estimatedCost: 1000,
          content: 'Description',
          outerOrderId: 'Not necessary',
          tariff: 'Tariff',
          length: 1.0,
          width: 1.0,
          height: 1.0,
          weigth: 1.0
        }
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/express/apiCreate')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.create(request_body) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
