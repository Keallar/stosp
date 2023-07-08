# frozen_string_literal: true

RSpec.describe Stosp::Client::CheckOrders, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#check_orders' do
    let(:response_body) do
      {
        'result' => true,
        'messages' => [],
        'errors' => [],
        'data' => [
          {
            'articul' => '3463653',
            'size' => '-',
            'action' => 'add',
            'successful' => 2
          }
        ],
        'html' => '',
        'redirect' => nil
      }.to_json
    end
    let(:data_keys) do
      %w[articul size action successful]
    end

    before do
      stub_request(:post, 'https://www.100sp.ru/org/formation/apiCheckOrders')
        .with(query: { megaorderId: 405_710_374, orders: [{ articul: 3_463_653, action: 'assembled', count: 2 }] })
        .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
    end

    it 'return response with result true' do
      expect(client.check_orders(405_710_374, [{ articul: 3_463_653, action: 'assembled', count: 2 }])['result'])
        .to be_truthy
    end

    it 'return response with data' do
      expect(client.check_orders(405_710_374, [{ articul: 3_463_653, action: 'assembled', count: 2 }])['data'])
        .to be_instance_of(Array)
    end

    it 'return response with data has keys' do
      expect(client.check_orders(405_710_374, [{ articul: 3_463_653, action: 'assembled', count: 2 }])['data'].first)
        .to include(*data_keys)
    end
  end

  context 'with error' do
    let(:response_body) do
      {
        "result": false,
        "messages": [],
        "errors": ['error'],
        "data": [
          {
            "articul": '3463653',
            "size": '-',
            "action": 'add',
            "errors": []
          }
        ],
        "html": '',
        "redirect": nil
      }.to_json
    end

    before do
      stub_request(:post, 'https://www.100sp.ru/org/formation/apiCheckOrders')
        .with(query: { megaorderId: 405_710_374, orders: [{ articul: 3_463_653, action: 'assembled', count: 2 }] })
        .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
    end

    it 'raise error' do
      expect do
        client.check_orders(405_710_374,
                            [{ articul: 3_463_653, action: 'assembled', count: 2 }])
      end.to raise_error(HTTParty::Error)
    end
  end

  context 'with error in data' do
    let(:response_body) do
      {
        "result": true,
        "messages": [],
        "errors": [],
        "data": [
          {
            "articul": '3463653',
            "size": '-',
            "action": 'add',
            "errors": [
              'Вы пытаетесь собрать заказы: 2. Доступно заказов для сборки: 0.'
            ]
          }
        ],
        "html": '',
        "redirect": nil
      }.to_json
    end

    before do
      stub_request(:post, 'https://www.100sp.ru/org/formation/apiCheckOrders')
        .with(query: { megaorderId: 405_710_374, orders: [{ articul: 3_463_653, action: 'assembled', count: 2 }] })
        .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
    end

    it 'raise exception' do
      expect do
        client.check_orders(405_710_374,
                            [{ articul: 3_463_653, action: 'assembled', count: 2 }])
      end.to raise_error(HTTParty::Error)
    end
  end
end
