!/bin/bash

# Set directory for reports and file names
resfldr='Reports/'
environment_filename="postman_environment.json"
collection_filename="postman_collection.json"

echo "Running Sustainability Svc API Automation Suite:"
# Run the Postman collection with Newman and generate Allure-compatible results
newman run $collection_filename -e $environment_filename --verbose -r cli,allure --reporter-allure-export "$resfldr"
# Generate Allure report from the generated results
allure generate $resfldr --clean -o $resfldr/allure-report

