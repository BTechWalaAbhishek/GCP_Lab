echo "${YELLOW}${BOLD}Starting${RESET}" "${GREEN}${BOLD}Execution${RESET}"

export OAUTH2_TOKEN=$(gcloud auth print-access-token)

gcloud services enable fitness.googleapis.com

echo '{
  "name": "'"$DEVSHELL_PROJECT_ID"'-bucket",
  "location": "us",
  "storageClass": "multi_regional"
}' > values.json

curl -X POST --data-binary @values.json \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: application/json" \
    "https://www.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"

curl -X POST --data-binary @/home/student_01_0890a57830ff/demo-image.png \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: image/png" \
    "https://www.googleapis.com/upload/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket/o?uploadType=media&name=demo-image"
