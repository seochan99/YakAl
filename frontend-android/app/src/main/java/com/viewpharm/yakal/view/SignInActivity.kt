package com.viewpharm.yakal.view

import android.os.Bundle
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.kakao.sdk.auth.model.OAuthToken
import com.kakao.sdk.common.model.ClientError
import com.kakao.sdk.common.model.ClientErrorCause
import com.kakao.sdk.user.UserApiClient
import com.viewpharm.yakal.BuildConfig
import com.viewpharm.yakal.databinding.ActivitySignInBinding
import com.viewpharm.yakal.repository.GoogleAuthRepository
import com.viewpharm.yakal.repository.OAuth2Repository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class SignInActivity : AppCompatActivity(), OAuth2Repository.CallBack {
    private lateinit var binding: ActivitySignInBinding
    private val options : GoogleSignInOptions = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
        .requestServerAuthCode(BuildConfig.GOOGLE_CLIENT_ID)
        .requestProfile().build() // profile 정보 포함
    private lateinit var googleSignInClient : GoogleSignInClient
    private val resultLauncher = registerForActivityResult(ActivityResultContracts
        .StartActivityForResult()) { result ->
        val authCode = GoogleSignIn.getSignedInAccountFromIntent(result.data).getResult(ApiException::class.java).serverAuthCode!!
        Timber.d("authCode : $authCode")
        googleAuthRepository.getOauth2Token(authCode, this@SignInActivity)
                    }
    private val googleAuthRepository = GoogleAuthRepository()

    private var oauthToken : String = ""


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySignInBinding.inflate(layoutInflater)
        setContentView(binding.root)
        googleSignInClient = GoogleSignIn.getClient(this, options)

        binding.kakaoLoginButton.setOnClickListener {
            // 이메일 로그인 콜백
            val mCallback: (OAuthToken?, Throwable?) -> Unit = { token, error ->
                if (error != null) {
                    Timber.e("로그인 실패 $error")
                } else if (token != null) {
                    oauthToken = token.accessToken
                    Timber.e("로그인 성공 ${token.accessToken}")
                }
            }

            // 카카오톡 설치 확인
            if (UserApiClient.instance.isKakaoTalkLoginAvailable(this@SignInActivity)) {

                UserApiClient.instance.loginWithKakaoTalk(this@SignInActivity) { token, error ->
                    // 카카오톡 로그인
                    // 로그인 실패 부분
                    if (error != null) {
                        Timber.e("로그인 실패 $error")
                        error.printStackTrace()
                        // 사용자가 취소
                        if (error is ClientError && error.reason == ClientErrorCause.Cancelled) {
                            return@loginWithKakaoTalk
                        }
                        // 다른 오류
                        else {
                            UserApiClient.instance.loginWithKakaoAccount(
                                this@SignInActivity,
                                callback = mCallback
                            ) // 카카오 이메일 로그인
                        }
                    }
                    // 로그인 성공 부분
                    else if (token != null) {
                        oauthToken = token.accessToken
                        Timber.e("로그인 성공 ${token.accessToken}")
                    }
                }
            } else {
                // 카카오 계정 로그인
                UserApiClient.instance.loginWithKakaoAccount(this@SignInActivity, callback = mCallback) // 카카오 이메일 로그인
            }
        }

        binding.googleLoginButton.setOnClickListener {
            googleSignInClient.signOut()
            val signInIntent = googleSignInClient.signInIntent
            resultLauncher.launch(signInIntent)
        }
    }



    override fun onSuccess(token: String) {
        oauthToken = token
        Timber.d("로그인 성공 $token")
    }

    override fun onFailure() {
        Timber.d("로그인 실패")
    }
}