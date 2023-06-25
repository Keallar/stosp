# frozen_string_literal: true

RSpec.describe Stosp::Client::ExportFullReport, type: :integration do
  let(:client) { Stosp::Client.new(access_token: nil) }
  describe '#export_full_report' do
    context 'with error' do
      let(:response_body) do
        {
          'result' => false,
          'messages' => [],
          'errors' => ['Ошибка 0: У вас недостаточно прав для выполнения указанного действия'],
          'data' => nil,
          'html' => '',
          'redirect' => nil
        }.to_json
      end
      before do
        stub_request(:get, 'https://www.100sp.ru/org/default/apiExportFullReport')
          .to_return(body: response_body, status: 200, headers: { content_type: 'application/json' })
      end

      it 'raise exception' do
        expect { client.export_full_report }.to raise_error(HTTParty::Error)
      end
    end
  end
end
