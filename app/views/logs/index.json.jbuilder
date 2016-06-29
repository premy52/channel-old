json.array!(@logs) do |log|
  json.extract! log, :id, :logdate, :log_notes, :outcome, :review, :action, :actiondate, :action_status, :parent_id, :banner_id, :distributor_id, :dc_id, :broker, :_id, :manager_id, :store_id
  json.url log_url(log, format: :json)
end
