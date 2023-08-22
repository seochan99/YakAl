package com.viewpharm.yakal.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.navArgs
import com.viewpharm.yakal.R
import com.viewpharm.yakal.databinding.FragmentSignUpTermDetailBinding
import com.viewpharm.yakal.type.ETerm
import com.viewpharm.yakal.view.SignUpActivity

class SignUpTermDetailFragment : Fragment() {
    private var _binding: FragmentSignUpTermDetailBinding? = null
    private val binding get() = _binding!!

    private val safeArgs: SignUpTermDetailFragmentArgs by navArgs()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentSignUpTermDetailBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        (activity as SignUpActivity).setToolbarTitle(safeArgs.termType.toString())
        binding.termDetailTextView.text = when(safeArgs.termType) {
            ETerm.SERVICE -> getString(R.string.serviceTerms)
            ETerm.INFORMATION -> getString(R.string.informationTerms)
            ETerm.LOCATION -> getString(R.string.locationTerms)
            ETerm.MARKETING -> getString(R.string.marketingTerms)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}