json.array!(@messages) do |message|
  json.extract! message, :id, :user_id, :event_id, :msg, :timestamp
  json.url message_url(message, format: :json)
end
