class AuthenticateUser
    def initialize(email, password)
        @email = email
        @password = password
    end

    # Sevice entry point
    def call_api
        JsonwebToken.encode(user_id: user.id) if user
    end


    private

    attr_reader :email, :password

    # Verify user credentials
    def user
        user = User.find_by(email: email)
        return user if user && user.authenticate(password)
        # Raise AuthenticationError if credentials are invalid
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end
