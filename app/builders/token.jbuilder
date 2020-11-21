json.status status
if status == 200
  json.token do
    json.(@token, :key)
  end
else
  json.error do
    json.message @error
  end
end
