# frozen_string_literal: true

RSpec.describe Stosp::Client::ProcessOrders, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }
  describe '#process_orders' do
    context 'with successfully' do
      let(:response_body) do
        { 'result' => true,
          'messages' => [],
          'errors' => [],
          'data' =>
           [{ 'collection_name' => 'Окислительная эмульсия ActiOx с экстрактом женьшеня',
              'goods_articul' => '1163-ks',
              'goods_name' => 'Кремообразная окислительная эмульсия 6% ActiOx Studio с экстрактом женьшеня и рисовыми протеинами, 150мл',
              'gid' => '612626',
              'user_id' => '126126',
              'user_name' => '621366',
              'goods_description' => 'Описание',
              'goods_price' => '116,10',
              'size_name' => '-',
              'distributor_id' => '38911',
              'distributor_name' => 'Южный парк',
              'megaorder_id' => '863562699',
              'purchase_id' => '1001047',
              'source' => nil,
              'comment' => nil,
              'megaorder_comment' => nil,
              'goods_picture' => 'https://cdn.100sp.ru/cache_pictures/958703405/thumb300',
              'sku' => nil,
              'barcode' => '4627087167264',
              'storageLocation' => nil,
              'order_id' => '343209166',
              'orders_descriptions' => '',
              'orders_count' => 1,
              'confirmed_orders_count' => 1,
              'finished_orders_count' => 0,
              'not_delivered_orders_count' => 0 }],
          'html' => '',
          'redirect' => nil }.to_json
      end
      let(:data_keys) do
        %w[collection_name
           goods_articul
           goods_name
           gid
           user_id
           user_name
           goods_description
           goods_price
           size_name
           distributor_id
           distributor_name
           megaorder_id
           purchase_id
           source
           comment
           megaorder_comment
           goods_picture
           sku
           barcode
           storageLocation
           order_id
           orders_descriptions
           orders_count
           confirmed_orders_count
           finished_orders_count
           not_delivered_orders_count]
      end
      before do
        stub_request(:get, 'https://www.100sp.ru/org/purchase/processOrders/api')
          .with(query: { pid: 1_001_047 })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end
      it 'return response with result: true' do
        expect(client.process_orders(1_001_047)['result']).to be_truthy
      end

      it 'return response with data' do
        expect(client.process_orders(1_001_047)['data']).to be_instance_of(Array)
        expect(client.process_orders(1_001_047)['data'].first.keys).to contain_exactly(*data_keys)
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
        stub_request(:get, 'https://www.100sp.ru/org/purchase/processOrders/api')
          .with(query: { pid: 1_001_047 })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end
      it 'raise exception' do
        expect { client.process_orders(1_001_047) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
