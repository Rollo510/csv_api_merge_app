require_relative "./environment"
require 'csv'


class TestApplication

    # URL for API
    URL = "http://interview.wpengine.io/v1/accounts"

    def initialize()
    end

    # Store accounts from API and from given csv file
    API_ACCOUNTS = []
    INPUT_ACCOUNTS = []
    
    # getting API accounts
    def get_accounts
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        parsed_data = JSON.parse(response.body)["results"]
        parsed_data.each do |account|
            API_ACCOUNTS << ["#{account["account_id"]}", "null", "#{account["created_on"]}", "#{account["status"]}", "null"]
        end
    end

    
    # getting one account
    def get_account(id)
        uri = URI.parse(URL + "/#{id}")
        response = Net::HTTP.get_response(uri)
        accounts = JSON.parse(response.body)
        puts accounts
    end

    # getting input.csv accounts / hard-coded "input.csv" file (in the main directory in this case)
    def run
        table = CSV.parse(File.read("input.csv"), headers: true)
        table.each do |account|
            INPUT_ACCOUNTS << ["#{account["Account ID"]}", "#{account["First Name"]}", "#{account["Created On"]}", "null", "null"]
        end
    end
    
    # method to merge accounts
    def merge
        get_accounts
        run
        header = ["Account ID", "First Name", "Created On", "Status", "Status Set On"]
        CSV.open("output.csv", "r+") do |csv|
            csv << header
            API_ACCOUNTS.each do |account|
                csv << account
            end
            INPUT_ACCOUNTS.each do |account|
                csv << account
            end
        end
    end

    
    # getting one account

    # def get_account(id)
    #    uri = URI.parse(URL + "/#{id}")
    #    response = Net::HTTP.get_response(uri)
    #    accounts = JSON.parse(response.body)
    #    puts accounts
    # end

    # getting input.csv accounts

    # def run
    #   table = CSV.parse(File.read("input.csv"), headers: true)
    #    table.each do |account|
    #        get_account(account["Account ID"])
    #    end
    # end 
   


end