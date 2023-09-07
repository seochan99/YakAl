package com.viewpharm.yakal.signin

import android.content.Intent
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.kakao.sdk.auth.model.OAuthToken
import com.kakao.sdk.common.model.ClientError
import com.kakao.sdk.common.model.ClientErrorCause
import com.kakao.sdk.user.UserApiClient
import com.viewpharm.yakal.BuildConfig
import com.viewpharm.yakal.R
import com.viewpharm.yakal.base.BaseActivity
import com.viewpharm.yakal.databinding.ActivitySignInBinding
import com.viewpharm.yakal.repository.GoogleAuthRepository
import com.viewpharm.yakal.repository.AuthRepository
import com.viewpharm.yakal.signup.activity.SignUpActivity
import timber.log.Timber


class SignInActivity : BaseActivity<ActivitySignInBinding, SignInViewModel>(R.layout.activity_sign_in) {
    override val viewModel: SignInViewModel by lazy {
        SignInViewModel.SignInViewModelFactory(
            AuthRepository(context = this),
            GoogleAuthRepository()
        ).create(SignInViewModel::class.java)
    }

    private val options : GoogleSignInOptions = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
        .requestServerAuthCode(BuildConfig.GOOGLE_CLIENT_ID)
        .requestProfile().build() // profile 정보 포함
    private lateinit var googleSignInClient : GoogleSignInClient
    private val resultLauncher = registerForActivityResult(ActivityResultContracts
        .StartActivityForResult()) { result ->
        try {
            val authCode = GoogleSignIn.getSignedInAccountFromIntent(result.data).getResult(ApiException::class.java).serverAuthCode!!
//            googleAuthRepository.getOauth2Token(authCode, this@SignInActivity)
        } catch (e: ApiException) {
            Timber.e("로그인 실패 ${e.message}")
            e.printStackTrace()
            Toast.makeText(this, "로그인 실패", Toast.LENGTH_SHORT).show()
        }
    }

    override fun initView() {
        super.initView()

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
                        viewModel.signInWithKakao(token.accessToken)
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

    override fun initViewModel() {
        super.initViewModel()
        binding.viewModel = viewModel
    }

    override fun initListener() {
        super.initListener()
        viewModel.inputEvent.observe(this) { event ->
            event.getContentIfNotHandled()?.let {
                when(viewModel.eventTag) {
                    SignInViewModel.Companion.EventTag.LOAD_GOOGLE_TOKEN,
                    SignInViewModel.Companion.EventTag.LOAD_REMOTE_TOKEN -> {
                        viewModel.saveJwtInDevice()
                        startActivity(Intent(this@SignInActivity, SignUpActivity::class.java))
                    }
                    SignInViewModel.Companion.EventTag.FAIL -> {
                        Toast.makeText(this, "로그인 실패", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }

    private fun mCallback(): (OAuthToken?, Throwable?) -> Unit {
        return { token, error ->
            if (error != null) {
                Timber.e("소셜 로그인 실패 $error")
            } else if (token != null) {
                viewModel.signInWithKakao(token.accessToken)
            }
        }
    }
}