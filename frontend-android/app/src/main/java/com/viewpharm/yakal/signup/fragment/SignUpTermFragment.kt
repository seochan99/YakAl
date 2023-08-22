package com.viewpharm.yakal.signup.fragment

import android.graphics.Typeface
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.StyleSpan
import android.view.View
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.navigation.Navigation
import com.viewpharm.yakal.R
import com.viewpharm.yakal.event.ActionViewModel
import com.viewpharm.yakal.base.BaseFragment
import com.viewpharm.yakal.databinding.FragmentSignUpTermBinding
import com.viewpharm.yakal.signup.viewmodel.SignUpTermViewModel
import com.viewpharm.yakal.type.ETerm
import timber.log.Timber

class SignUpTermFragment: BaseFragment<FragmentSignUpTermBinding, SignUpTermViewModel>(R.layout.fragment_sign_up_term) {

    override val baseViewModel: SignUpTermViewModel by viewModels {
        SignUpTermViewModel.SignUpTermViewModelFactory()
    }

    private val actionViewModel: ActionViewModel by viewModels() {
        ActionViewModel.ActionViewModelFactory()
    }

    override fun onResume() {
        super.onResume()
        Timber.d("onResume")
    }

    override fun initView() {
        super.initView()

        val titleText: String = "약관을 확인해주세요"
        binding.termTitleTextView.text = titleText.run {
            SpannableStringBuilder(this).apply {
                setSpan(
                    StyleSpan(Typeface.BOLD),
                    0,
                    2,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }
    }

    override fun initViewModel() {
        super.initViewModel()
        binding.baseViewModel = baseViewModel
        binding.actionViewModel = actionViewModel
    }

    override fun initListener(view: View) {
        super.initListener(view)

        // All Agree CheckBox Click Event
        baseViewModel.agreeState.observe(this.viewLifecycleOwner, Observer {
        })

        // Next Button Click Event
        actionViewModel.addScheduleEvent.observe(this.viewLifecycleOwner, Observer {
            it.getContentIfNotHandled()?.let {
                Navigation.findNavController(view).navigate(R.id.action_to_signUpCertificationFragment)
            }
        })
    }
}