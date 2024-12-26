POSTMAN_COLLECTION_PATH="postman_collection.json"
POSTMAN_ENVIRONMENT_PATH="postman_environment.json"
REPORT_PATH="./api-automation/Reports"
ALLURE_REPORT_PATH="./api-automation/allure-report"

mkdir -p $REPORT_PATH

echo "Running Newman Collection..."
newman run $POSTMAN_COLLECTION_PATH \
  -e $POSTMAN_ENVIRONMENT_PATH \
  --reporters cli,allure \
  --reporter-allure-export $REPORT_PATH

if [ $? -eq 0 ]; then
  echo "Postman tests passed successfully!"
else
  echo "Postman tests failed!"
  echo "Contents of $REPORT_PATH after Newman run:"
  ls -alh $REPORT_PATH
  exit 1
fi

echo "Generating Allure Report..."
allure generate $REPORT_PATH -o $ALLURE_REPORT_PATH || { echo "Allure report generation failed."; exit 1; }

if [ ! -d "$ALLURE_REPORT_PATH" ] || [ -z "$(ls -A $ALLURE_REPORT_PATH)" ]; then
  echo "ERROR: Allure report directory is empty or does not exist."
  echo "Contents of $REPORT_PATH after Allure report generation:"
  ls -alh $REPORT_PATH
  exit 1
fi

echo "Reports directory contents:"
ls -alh $REPORT_PATH
echo "Allure report directory contents:"
ls -alh $ALLURE_REPORT_PATH
