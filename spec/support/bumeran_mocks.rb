require 'webmock/rspec'

module BumeranMocks
  def stub_bumeran_login
    request_headers = {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }

    json_response_login= JSON.parse(File.read('spec/factories/response_get_login.json'))
    stub_request(:post, "https://developers.bumeran.com/v0/empresas/usuarios/oauth2/login?client_id=&client_secret=&grant_type=password&password=&username=").
       with(headers: request_headers).
       to_return(status: 200, body: json_response_login.to_json, headers: {})
  end

  def stub_bumeran_get_postulations
    request_headers = {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
    }

    json_response_page_0 = JSON.parse(File.read('spec/factories/response_get_postulations_in_publication_0.json'))
    json_response_page_1 = JSON.parse(File.read('spec/factories/response_get_postulations_in_publication_1.json'))
    
    publication_id = "1231212"
    postulations_per_page =1

    pages = [0, 1]
    pages.each do |page_number|
      get_postulations_in_publication_path = "https://developers.bumeran.com/v0/empresas/avisos/#{publication_id}/postulaciones?access_token=access_token&page=#{page_number}&pageSize=#{postulations_per_page}"
      stub_request(:get, get_postulations_in_publication_path).
       with(headers: request_headers).
       to_return(status: 200, body: JSON.parse(File.read("spec/factories/response_get_postulations_in_publication_#{page_number}.json")).to_json, headers: {})
    end
  end
end