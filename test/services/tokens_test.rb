require 'test_helper'

class TokensTest < ActiveSupport::TestCase
  setup do
    @token_service = Tokens.new()
    @logger = Logger.new(STDOUT)
  end

  test "expires in" do
    results = @token_service.expires_in(1)
    assert_not_nil (results), "no results from expires in"
    assert results.is_a?(Integer), "results is not an integer"
  end

  test "generate token" do
    assert_not_nil @token_service.generate_token(1, 1)
  end

  test "get user by token" do
    uuid = 'fbf5006a-f7b7-487a-a911-dea23fa4b38a'
    token = @token_service.generate_token(uuid, 1)
    user = @token_service.get_user_by_token(token)
    assert_not_nil token, "token is nil"
    assert_not_nil user, "user is nil"
    assert user.uuid  == 'fbf5006a-f7b7-487a-a911-dea23fa4b38a', "user id is wrong"
  end

  test "get user with expired token" do
    uuid = 'fbf5006a-f7b7-487a-a911-dea23fa4b38a'
    token = @token_service.generate_token(uuid, -1)
    result = @token_service.get_user_by_token(token)
    assert_not_nil token, "did not create token"
    assert_nil result, "result is not nil"
  end

  test "get no user by token" do
    uuid = 'notanidthatisused'
    token = @token_service.generate_token(uuid, 1)
    result = @token_service.get_user_by_token(token)
    assert_nil result, "should not return without user"
  end

end
