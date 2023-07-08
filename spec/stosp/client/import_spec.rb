# frozen_string_literal: true

RSpec.describe Stosp::Client::Import, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }

  describe '#import' do
    let(:request_body) do
      {
        'purchase' => 153_970,
        'duplicate' => 'articul',
        'overwrite[name]' => 'name',
        'overwrite[price]' => 'price',
        'overwrite[description]' => 'description',
        'overwrite[comment]' => 'comment',
        'overwrite[weight]' => 'weight',
        'photos' => 'all',
        'missing' => 'nothing',
        'remains' => 'add',
        'collections' => 'update',
        'delimiter' => ',',
        'file' => ''
      }
    end

    context 'with successfully' do
      let(:response_body) do
        {
          messages: [],
          errors: [],
          data: {
            asyncJobId: 1_234_567,
            changes: [
              {
                goodId: 987,
                param: 'String',
                oldValue: '',
                newValue: '',
                new: true
              }
            ]
          }
        }.to_json
      end
      let(:changes_keys) do
        %w[goodId param oldValue newValue new]
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/org/purchase/importExport/apiImport')
          .with(query: request_body)
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'return response with data changes keys' do
        expect(client.import(request_body)['data']['changes'].first).to include(*changes_keys)
      end
    end

    context 'with error' do
      let(:response_body) do
        {
          messages: [],
          errors: ['Некорректный POST-запрос'],
          data: {},
          html: '',
          redirect: nil
        }.to_json
      end

      before do
        stub_request(:post, 'https://www.100sp.ru/org/purchase/importExport/apiImport')
          .with(query: {})
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.import({}) }.to raise_error(HTTParty::Error)
      end
    end
  end
end
