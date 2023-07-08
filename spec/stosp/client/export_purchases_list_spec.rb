# frozen_string_literal: true

RSpec.describe Stosp::Client::ExportPurchasesList, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#export_purchases_list' do
    context 'with successfully' do
      let(:response_body) do
        { 'result' => true,
          'messages' => [],
          'errors' => [],
          'data' =>
           [{ 'pid' => '1001047', 'name' => 'Средства для создания укладки с эксклюзивной технологией',
              'statusLabel' => 'Активна', 'statusCode' => '16' }],
          'html' => '',
          'redirect' => nil }.to_json
      end
      let(:data_keys) do
        %w[pid name statusLabel statusCode]
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/purchase/apiExportPurchasesList')
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with result: true' do
        expect(client.export_purchases_list['result']).to eq(true)
      end

      it 'return response with data of Array' do
        expect(client.export_purchases_list['data']).to be_instance_of(Array)
      end

      it 'return response with data keys' do
        expect(client.export_purchases_list['data'].first).to include(*data_keys)
      end
    end

    context 'with error' do
      let(:response_body) do
        { 'result' => false,
          'messages' => [],
          'errors' => ['error'],
          'data' => [],
          'html' => '',
          'redirect' => nil }.to_json
      end

      before do
        stub_request(:get, 'https://www.100sp.ru/purchase/apiExportPurchasesList')
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.export_purchases_list }.to raise_error(HTTParty::Error)
      end
    end
  end
end
