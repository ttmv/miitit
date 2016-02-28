json.array!(@events) do |event|
  json.extract! event, :id, :name, :time, :info
  json.url event_url(event, format: :json)
end
