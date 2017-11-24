def authenticated_header
  user = User.create(email: 'login@mail.com', password: 'secret')
  token = Knock::AuthToken.new(payload: { sub: user.id }).token
  {
    'Authorization': "Bearer #{token}"
  }
end
