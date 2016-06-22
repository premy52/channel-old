json.array!(@brokerages) do |brokerage|
  json.extract! brokerage, :id, :company, :address1, :address2, :city, :state, :zip, :rate
  json.url brokerage_url(brokerage, format: :json)
end
