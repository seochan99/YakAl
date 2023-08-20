package com.viewpharm.yakal.view

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
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
import com.viewpharm.yakal.repository.YakalRepository
import com.viewpharm.yakal.repository.YakalRepositoryImpl
import com.viewpharm.yakal.type.ESignInProvider
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import timber.log.Timber


class SignInActivity : AppCompatActivity(), OAuth2Repository.CallBack, YakalRepository.CallBack {
    private lateinit var binding: ActivitySignInBinding

    private val options : GoogleSignInOptions = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
        .requestServerAuthCode(BuildConfig.GOOGLE_CLIENT_ID)
        .requestProfile().build() // profile 정보 포함
    private lateinit var googleSignInClient : GoogleSignInClient
    private val resultLauncher = registerForActivityResult(ActivityResultContracts
        .StartActivityForResult()) { result ->
        try {
            val authCode = GoogleSignIn.getSignedInAccountFromIntent(result.data).getResult(ApiException::class.java).serverAuthCode!!
            googleAuthRepository.getOauth2Token(authCode, this@SignInActivity)
        } catch (e: ApiException) {
            Toast.makeText(this, "로그인 실패", Toast.LENGTH_SHORT).show()
        }

    }

    private val googleAuthRepository: OAuth2Repository = GoogleAuthRepository()
    private val yakalRepository: YakalRepository = YakalRepositoryImpl()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySignInBinding.inflate(layoutInflater)
        setContentView(binding.root)
        googleSignInClient = GoogleSignIn.getClient(this, options)

        binding.kakaoLoginButton.setOnClickListener {
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
                                callback = mCallback()
                            ) // 카카오 이메일 로그인
                        }
                    }
                    // 로그인 성공 부분
                    else if (token != null) {
                        yakalRepository.getYakalToken(token.accessToken, ESignInProvider.KAKAO,this@SignInActivity)
                    }
                }
            } else {
                // 카카오 계정 로그인
                UserApiClient.instance.loginWithKakaoAccount(this@SignInActivity, callback = mCallback()) // 카카오 이메일 로그인
            }
        }

        binding.googleLoginButton.setOnClickListener {
            googleSignInClient.signOut()
            val signInIntent = googleSignInClient.signInIntent
            resultLauncher.launch(signInIntent)
        }
    }

    private fun mCallback(): (OAuthToken?, Throwable?) -> Unit {
        return { token, error ->
            if (error != null) {
                Timber.e("소셜 로그인 실패 $error")
            } else if (token != null) {
                yakalRepository.getYakalToken(token.accessToken, ESignInProvider.KAKAO,this@SignInActivity)
            }
        }
    }



    override fun onSuccess(token: String) {
        yakalRepository.getYakalToken(token, ESignInProvider.GOOGLE,this@SignInActivity)
    }

    override fun onFailure() {
        Timber.d("소셜 로그인 실패")
    }

    override fun getToken(accessToken: String, refreshToken: String) {
        getSharedPreferences("token", MODE_PRIVATE).edit().apply {
            putString("accessToken", accessToken)
            putString("refreshToken", refreshToken)
            apply()
        }

        Intent(this, SignUpActivity::class.java).let {
            startActivity(it)
        }

        Timber.d("AccessToken: $accessToken" +
                "\nRefreshToken: $refreshToken")
        finish()
    }

    override fun failToken() {
        Timber.d("서버 로그인 실패")
    }
}