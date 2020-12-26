# frozen_string_literal: true

# 継承。下記super付きはdevise用メソッドをそのまま実行できる。
# コメントアウトされている部分について、同名のメソッドを定義することにより、上書きできる。
class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    # @user = User.newと同意義
    super
  end

  def create
    @user = User.new(sign_up_params)
    # falseの場合にはnewアクションへ
    render :new and return unless @user.valid?

    # ハッシュオブジェクトの形で情報を代入（sessionに保持）
    session['devise.regist_data'] = { user: @user.attributes }
    # パスワードは含まれていないため追加で代入（[:password]でも値は取得出来た）
    session['devise.regist_data'][:user]['password'] = params[:user][:password]
    #  @userに紐づくAdressモデルのインスタンスを生成（buildメソッドでモデル間を関連付け）
    @address = @user.build_address
    # 住所登録ページへ
    render :new_address
  end

  def create_address
    @user = User.new(session['devise.regist_data']['user'])
    @address = Address.new(address_params)
    # 「and return」で処理を中断し、バリデーションチェック（あっていない場合にはnew_addressアクションに画面遷移）
    render :new_address and return unless @address.valid?
    # バリデーションチェックが完了した情報とsessionで保持した情報を合わせ、ユーザー情報として保存
    @user.build_address(@address.attributes)
    @user.save
    # sessionを削除
    session['devise.regist_data']['user'].clear
    # ユーザーの新規登録ができてもログインできているわけではないため、sign_inメソッドを利用してログインする
    sign_in(:user, @user)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
