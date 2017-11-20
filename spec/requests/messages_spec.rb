require 'rails_helper'

describe 'Messages' do
  let(:params) { { 'body' => 'Some text',
                   'deliver_in' => Time.now.to_s,
                   'destinations_attributes' => [{ 'messenger' => 'telegram',
                                                   'nickname' => 'jack' }]} }

  describe 'request with' do
    context 'valid params' do
      let(:request) { post '/message', params: params }

      it 'return success status' do
        request
        expect(response).to have_http_status 200
      end

      it 'create message' do
        expect { request }.to change { Message.count }.by 1
      end

      it 'create destination' do
        expect { request }.to change { Destination.count }.by 1
      end

      it 'create a few destination' do
        params_with_2_des = params.dup
        params_with_2_des['destinations_attributes'] << { 'messenger' => 'viber',
                                                          'nickname' => 'nick' }
        expect { post '/message', params: params_with_2_des }
            .to change { Destination.count }.by 2
      end
    end

    context 'invalid params' do
      after { expect(response).to have_http_status 422 }

      it 'body' do
        post '/message', params: params.except('body')
      end

      it 'destinations_attributes' do
        post '/message', params: params.except('destinations_attributes')
      end

      it 'messenger' do
        params['destinations_attributes'][0].except!('messenger')
        post '/message', params: params
      end

      it 'nickname' do
        params['destinations_attributes'][0].except!('nickname')
        post '/message', params: params
      end

      it 'invalid messenger' do
        params['destinations_attributes'][0]['messenger'] = 'skype'
        post '/message', params: params
      end
    end
  end
end
