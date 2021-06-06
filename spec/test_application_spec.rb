#require 'httparty'

--begin 
describe 'TestApplication' do
    describe '#get_accounts' do
       
            let(:test_account) { "http://interview.wpengine.io/v1/accounts"}
            let(:response) { instance_double(HTTParty::Response, body: api_response_body) }
            let(:api_response_body) { 'response_body' }
            
            before do
                allow(HTTParty).to receive(:get).and_return(response)
                allow(JSON).to receive(:parse)
            end

            it 'fetches accounts from the API' do
                expect(HTTParty).to have_received(:get).with(test_account)
            end

            it 'parses the API response' do
                expect(JSON).to have_received(:parse).with(api_response_body)
            end

    end
end
--end