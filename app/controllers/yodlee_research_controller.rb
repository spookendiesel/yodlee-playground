require 'net/http'
require 'uri'

class YodleeResearchController < ApplicationController
  def index
  end

  def authenticate_cobrand
    params = {
      "cobrandLogin" => cobrand_username,
      "cobrandPassword" => cobrand_password
    }
    @result = JSON.parse(http_request(cobrand_login_url, params).body)
    respond_to do |format|
      format.js {}
    end
  end

  def login_consumer
    token = params["session_token"]

    login_params = {
      "cobSessionToken" => token,
      "login" => user_username,
      "password" => user_password
    }

    @result = JSON.parse(http_request(user_login_url, login_params).body)
    respond_to do |format|
      format.js {}
    end
  end

  def get_user_accounts
    session_token = params["session_token_5"]
    user_token = params["user_session_token_3"]

    account_params = {
      "cobSessionToken" => session_token,
      "userSessionToken" => user_token
    }

    @result = JSON.parse(http_request(get_user_accounts_url, account_params).body).collect { |x| x["siteInfo"]["defaultDisplayName"] }
    respond_to do |format|
      format.js {}
    end
  end

  def search_sites
    session_token = params["session_token_2"]
    user_token = params["user_session_token"]
    search = params["site_search_field"]

    search_params = {
      "cobSessionToken" => session_token,
      "userSessionToken" => user_token,
      "siteSearchString" => search
    }

    result_list = JSON.parse(http_request(search_site_url, search_params).body).collect { |x| "#{x["defaultDisplayName"]} | #{x["siteId"]}" }

    @result = []

    result_list.each do |r|
      @result << "<div>#{r}</div>"
    end

    respond_to do |format|
      format.js {}
    end
  end

  def get_site_login_form

    session_token = params["session_token_3"]
    site_id = params["site_id"]

    login_form_params = {
      "cobSessionToken" => session_token,
      "siteId" => site_id
    }

    @result = JSON.parse(http_request(site_login_form_url, login_form_params).body)
    respond_to do |format|
      format.js {}
    end
  end

  def add_site_account
    session_token = params["session_token_4"]
    user_token = params["user_session_token_2"]
    site_id = params["site_id_2"]

    add_site_params = {
      "cobSessionToken" => session_token,
      "userSessionToken" => user_token,
      "siteId" => site_id,
      "credentialFields.enclosedType" => "com.yodlee.common.FieldInfoSingle",
      "credentialFields[0].displayName" => "Username",
      "credentialFields[0].fieldType.typeName" => "TEXT",
      "credentialFields[0].name" => "LOGIN",
      "credentialFields[0].value" => "twbtest.bank1",
      "credentialFields[0].valueIdentifier" => "LOGIN",

      "credentialFields[1].displayName" => "Password",
      "credentialFields[1].fieldType.typeName" => "IF_PASSWORD",
      "credentialFields[1].name" => "PASSWORD1",
      "credentialFields[1].value" => "bank1",
      "credentialFields[1].valueIdentifier" => "PASSWORD1"
    }

    @result = JSON.parse(http_request(add_site_url, add_site_params).body)

    require 'pry'; binding.pry
    respond_to do |format|
      format.js {}
    end
  end


  private

  def http_request(url, params)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Post.new(url.request_uri)
    request.form_data = params
    http.use_ssl = true  
    http.request(request)
  end

  def user_username
    "sbMemtwbaker1"
  end

  def user_password
    "sbMemtwbaker1#123"
  end

  def cobrand_username
    "sbCobtwbaker"
  end

  def cobrand_password
    "2c5c5015-0861-43f5-b81f-7b69d943051a"
  end

  def rest_url
    "https://rest.developer.yodlee.com/services/srest/restserver/v1.0/"
  end

  def cobrand_login_url
    URI.parse("#{rest_url}authenticate/coblogin")
  end

  def user_login_url
    URI.parse("#{rest_url}authenticate/login")
  end

  def search_site_url
    URI.parse("#{rest_url}jsonsdk/SiteTraversal/searchSite")
  end

  def site_login_form_url 
    URI.parse("#{rest_url}jsonsdk/SiteAccountManagement/getSiteLoginForm")
  end

  def add_site_url
    URI.parse("#{rest_url}jsonsdk/SiteAccountManagement/addSiteAccount1")
  end

  def get_user_accounts_url
    URI.parse("#{rest_url}jsonsdk/SiteAccountManagement/getSiteAccounts")
  end
end
