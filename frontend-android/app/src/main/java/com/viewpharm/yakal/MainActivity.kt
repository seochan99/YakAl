package com.viewpharm.yakal

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.add
import androidx.navigation.ui.setupWithNavController
import com.viewpharm.yakal.databinding.ActivityMainBinding
import com.viewpharm.yakal.databinding.FragmentHomeBinding
import com.viewpharm.yakal.ui.CommunityMainFragment
import com.viewpharm.yakal.ui.HomeMainFragment
import com.viewpharm.yakal.ui.LocationMainFragment
import com.viewpharm.yakal.ui.ProfileMainFragment

const val FRAGMENT_TAG_HOME = "home_fragment"
const val FRAGMENT_TAG_LOCATION = "location_fragment"
const val FRAGMENT_TAG_COMMUNITY = "community_fragment"
const val FRAGMENT_TAG_PROFILE = "profile_fragment"


class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.bottomNavigationView.setOnItemSelectedListener { item ->
            // 어떤 Fragment인지 확인
            val selectedFragment: Fragment = when (item.itemId) {
                R.id.locationMainFragment -> LocationMainFragment()
                R.id.communityMainFragment -> CommunityMainFragment()
                R.id.profileMainFragment -> ProfileMainFragment()
                else -> HomeMainFragment()
            }

            // FrameLayout을 해당 Fragment로 바꿔준다.
            supportFragmentManager.beginTransaction().apply {
                replace(binding.mainFrameLayout.id, selectedFragment)
                commit()
            }

            // setOnItemSelectedListener의 경우 반환이 필요하다.
            true
        }
    }
}