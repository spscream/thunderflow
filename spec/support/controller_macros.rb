module ControllerMacros
  def sign_in_user
    let(:user) {create(:user)}
    before do |e|
      unless e.metadata[:skip_sign_in]
        @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
      end
    end
  end
end
