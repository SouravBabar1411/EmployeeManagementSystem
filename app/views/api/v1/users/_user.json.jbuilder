json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.address do
  json.partial! 'api/v1/addresses/address', address: user.addresses
end