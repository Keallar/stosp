# frozen_string_literal: true

RSpec.describe Stosp::Client::PurchaseExport, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#purchase_export' do
    context 'with successfully' do
      let(:request_body) do
        {
          purchase: 123,
          purchases: [98, 53, 54]
        }
      end
      let(:response_body) do
        {
          result: true,
          messages: [],
          errors: [],
          data: [
            {
              gid: '1058667384',
              collection: '',
              articul: '',
              name: '',
              description: '',
              price: 142.12,
              priceWithFee: 123.42,
              recommendedPrice: 140.23,
              providerPrice: 130.32,
              sizes: '-@0',
              uuid: '130921572',
              source: nil,
              categoryId: 12_345,
              categoryName: 'Брашинг',
              weight: 5.0,
              height: nil,
              images: ['https://cdn.100sp.ru/pictures/965517528'],
              depth: nil,
              volume: nil,
              netto: '100',
              brutto: '120',
              width: nil
            }
          ]
        }.to_json
      end

      let(:data_keys) do
        %w[gid
           collection
           articul
           name
           description
           price
           priceWithFee
           recommendedPrice
           providerPrice
           sizes
           uuid
           source
           categoryId
           categoryName
           images
           width
           height
           depth
           volume
           netto
           brutto]
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/org/purchase/importExport/apiExport')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with result: true' do
        expect(client.purchase_export(request_body)[:result]).to eq(true)
      end

      it 'return response with data of Array' do
        expect(client.purchase_export(request_body)[:data]).to be_instance_of(Array)
      end

      it 'return response with data keys' do
        expect(client.purchase_export(request_body)[:data].first).to include(*data_keys)
      end
    end

    context 'with error' do
      let(:request_body) do
        {
          purchase: 123,
          purchases: [98, 53, 54]
        }
      end
      let(:response_body) do
        {
          result: false,
          messages: [],
          errors: ['Ошибка 0: Покупка не найдена'],
          data: nil
        }.to_json
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/org/purchase/importExport/apiExport')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.purchase_export(request_body) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
