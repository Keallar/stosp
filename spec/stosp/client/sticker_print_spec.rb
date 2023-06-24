# frozen_string_literal: true

RSpec.describe Stosp::Client::StickerPrint, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }
  describe '#sticker_print' do
    context 'with successfully' do
      let(:response_body) do
        {
          'messages' => [],
          'errors' => []
        }.to_json
      end
      before do
        stub_request(:get, 'https://www.100sp.ru/org/sticker/apiPrint')
          .with(query: { megaorderIds: 123, count: 2, format: 'pdf' })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return empty errors' do
        expect(client.sticker_print(123, { count: 2, format: 'pdf' })['errors'])
          .to be_empty
      end
    end

    context 'with error' do
      let(:response_body) do
        {
          'messages' => [],
          'errors' => ['error']
        }.to_json
      end
      before do
        stub_request(:get, 'https://www.100sp.ru/org/sticker/apiPrint')
          .with(query: { megaorderIds: 123, count: 2, format: 'pdf' })
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.sticker_print(123, { count: 2, format: 'pdf' }) }
          .to raise_error(HTTParty::Error)
      end
    end
  end
end
