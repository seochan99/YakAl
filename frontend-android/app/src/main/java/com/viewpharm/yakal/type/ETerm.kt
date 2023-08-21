package com.viewpharm.yakal.type

enum class ETerm(private val title: String) {
    SERVICE("서비스 이용약관"),
    INFORMATION("위치기반 서비스 이용약관"),
    LOCATION("개인정보 수집 및 이용약관"),
    MARKETING("마케팅 정보 활용약관");

    override fun toString(): String {
        return this.title
    }
}