json.array!(@order_members) do |order_member|
  json.extract! order_member, :id, :order_id, :user_id, :status_user
  json.url order_member_url(order_member, format: :json)
end
