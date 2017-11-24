require 'rails_helper'

describe 'Messages' do
  let(:params) do
    { 'body' => 'Some text',
      'deliver_in' => Time.now.to_s,
      'destinations_attributes' => [{ 'messenger' => 'telegram',
                                      'nickname' => 'jack' }] }
  end

  let(:request) do
    post '/message',
         params: params,
         headers: authenticated_header
  end

  describe 'request with' do
    context 'valid params' do
      it 'return success status' do
        request
        expect(response).to have_http_status 200
      end

      it 'message' do
        expect { request }.to change { Message.count }.by 1
      end

      it 'destination' do
        expect { request }.to change { Destination.count }.by 1
      end

      it 'a few destination' do
        params['destinations_attributes'] << { 'messenger' => 'viber',
                                               'nickname' => 'nick' }
        expect { request }.to change { Destination.count }.by 2
      end

      it 'only one destination with duplication params' do
        params['destinations_attributes'] <<
          params['destinations_attributes'][0]

        expect { request }.to change { Destination.count }.by 1
      end

      it 'without deliver_id' do
        params.except!('deliver_in')
        request
        expect(response).to have_http_status 200
      end
    end

    context 'invalid params' do
      after { expect(response).to have_http_status 422 }

      it 'body' do
        params.except!('body')
        request
      end

      it 'destinations_attributes' do
        params.except!('destinations_attributes')
        request
      end

      it 'messenger' do
        params['destinations_attributes'][0].except!('messenger')
        request
      end

      it 'nickname' do
        params['destinations_attributes'][0].except!('nickname')
        request
      end

      it 'messenger' do
        params['destinations_attributes'][0]['messenger'] = 'skype'
        request
      end

      it 'deliver_in' do
        params['deliver_in'] = 'this afternoon'
        request
      end
    end
  end
end
