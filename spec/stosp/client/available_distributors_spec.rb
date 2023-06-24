# frozen_string_literal: true

RSpec.describe Stosp::Client::AvailableDistributors, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }
  describe '#available_distributors' do
    context 'with successfully' do
      let(:response_body) do
        {
          'receive' =>
            [{
              'code' => '39', 'name' => 'Антей-транзит', 'city' => 'Владивосток', 'address' => 'ул. Енисейская, 32', 'additional_address' => ''
            }],
          'distribute' =>
            [{
              'code' => '17', 'name' => 'АРС-Центр', 'city' => 'Арсеньев', 'address' => 'ул. Ломоносовская, 21/1',
              'additional_address' => 'доп. номер +79140737221'
            }]
        }.to_json
      end
      before do
        stub_request(:get, 'https://www.100sp.ru/express/apiAvailableDistributors')
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with receive and distribute' do
        expect(client.available_distributors).to include('receive')
        expect(client.available_distributors).to include('distribute')
      end
    end
  end
end
