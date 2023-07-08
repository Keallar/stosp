# frozen_string_literal: true

RSpec.describe Stosp::Client::PurchaseExportMeta, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#purchase_export_meta' do
    context 'with successfully' do
      let(:response_body) do
        { 'result' => true,
          'messages' => [],
          'errors' => [],
          'data' =>
           { 'purchase' =>
              { 'id' => '1001047',
                'name' => 'Проф аксессуары и инструменты для ухода за волосами',
                'duration_type' => 'infinity',
                'visibility' => 'all',
                'megapurchase' => { 'id' => '103877', 'name' => 'Косметика' },
                'collections' =>
                 [{ 'id' => '17664558', 'name' => 'Salermvison перманентное окрашивание волос + оксиды',
                    'category' => { 'id' => '107355',
                                    'name' => 'Красота / Уход за волосами / Окрашивание и химическая завивка' } }] } },
          'html' => '',
          'redirect' => nil }.to_json
      end
      let(:data_keys) do
        %w[id name duration_type visibility megapurchase collections]
      end
      let(:collection_keys) do
        %w[id name category]
      end
      let(:category_keys) do
        %w[id name]
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/purchase/apiExportMeta')
          .with(query: { purchase: 1 })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with result: true' do
        expect(client.purchase_export_meta(1)).to be_truthy
      end

      it 'return response with data purchase' do
        expect(client.purchase_export_meta(1)['data']).to include('purchase')
      end

      it 'return response with data purchase keys' do
        expect(client.purchase_export_meta(1)['data']['purchase']).to include(*data_keys)
      end

      it 'return response with data purchase collections Array' do
        expect(client.purchase_export_meta(1)['data']['purchase']['collections']).to be_instance_of(Array)
      end

      it 'return response with data purchase collections expected keys' do
        expect(client.purchase_export_meta(1)['data']['purchase']['collections'].first).to include(*collection_keys)
      end

      it 'return response with data purchase collections category' do
        expect(client.purchase_export_meta(1)['data']['purchase']['collections']
                 .first['category']).to include(*category_keys)
      end
    end

    context 'with error' do
      let(:response_body) do
        { 'result' => false,
          'messages' => [],
          'errors' => [],
          'data' => [],
          'html' => '',
          'redirect' => nil }.to_json
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/purchase/apiExportMeta')
          .with(query: { purchase: 1 })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.purchase_export_meta(1) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
