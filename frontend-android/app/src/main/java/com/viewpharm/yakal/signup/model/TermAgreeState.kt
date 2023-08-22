package com.viewpharm.yakal.signup.model

data class TermAgreeState(
    val isAllAgreed: Boolean = false,
    val isEssentialAgreed: Boolean = false,
    val isServiceAgreed: Boolean = false,
    val isLocationAgreed: Boolean = false,
    val isInformationAgreed: Boolean = false,
    val isMarketingAgreed: Boolean = false,
) {
    fun isEssentialAgree(): Boolean {
        return isServiceAgreed && isLocationAgreed && isInformationAgreed
    }

    fun isAllAgree(): Boolean {
        return isServiceAgreed && isLocationAgreed && isInformationAgreed && isMarketingAgreed
    }
}