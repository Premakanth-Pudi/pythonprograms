#!/bin/bash

# Set directory for reports and file names
resfldr='Reports/'
environment_filename="postman_environment.json"
collection_filename="postman_collection.json"

echo "Running Sustainability Svc API Automation Suite:"
# Run the Postman collection with Newman and specify the report export directory
newman run $collection_filename -e $environment_filename --verbose -r cli,allure --reporter-allure-export "$resfldr"

# Generate Allure report from the specified directory
allure generate --clean $resfldr --report-name "Sustainability_Svc_Report
