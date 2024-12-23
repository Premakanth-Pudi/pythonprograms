from flask import Flask, jsonify, request
import json
from datetime import datetime

app = Flask(__name__)

#It is used to read company data from the Json file
def load_company_data():
    with open('company_data.json', 'r') as file:
        return json.load(file)

# API endpoint to fetch the share price for a given ticker symbol
@app.route('/get_share_price', methods=['GET'])
def get_share_price():
    
    company_data = load_company_data()

   # It is used to get the ticker symbol from file
    ticker_symbol = request.args.get('ticker_symbol')

    # Search for the company with the given ticker symbol
    for company in company_data:
        if company['ticker_symbol'] == ticker_symbol:
            # to get the current date we used this.
            current_date = datetime.now().strftime("%Y-%m-%d")  #used to format the time 

            # it is used to format the share price with two decimal places we use .2f
            formatted_share_price = "{:,.2f}".format(company['share_price']) 

            # Write the share price and date to a new file
            file_name = f"{ticker_symbol}.txt"
            with open(file_name, 'w') as output_file:
                output_file.write(f"Date of the call: {current_date}\n")
                output_file.write(f"Share price for {ticker_symbol}: ${formatted_share_price}\n")

            # Read the data of the file
            with open(file_name, 'r') as file_content:
                contents = file_content.read()

           
            return contents

    # If the given ticker symbol Not Present in the json file we created  
    return jsonify({"error": "Ticker symbol not found"}), 404

if __name__ == '__main__':
    app.run(debug=True, port=8080)