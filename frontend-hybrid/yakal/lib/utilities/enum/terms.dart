enum ETerms {
  TERMS_OF_USE,
  CONSENT_TO_PROVIDE_PERSONAL_INFO,
  LOCATION_BASED,
  MARKETING,
}

extension ETermsExtension on ETerms {
  String get fileName {
    switch (this) {
      case ETerms.TERMS_OF_USE:
        return "terms_of_use";
      case ETerms.CONSENT_TO_PROVIDE_PERSONAL_INFO:
        return "consent_to_provide_pi";
      case ETerms.LOCATION_BASED:
        return "location_based";
      case ETerms.MARKETING:
        return "marketing";
      default:
        return "";
    }
  }

  String get title {
    switch (this) {
      case ETerms.TERMS_OF_USE:
        return "서비스 이용약관";
      case ETerms.CONSENT_TO_PROVIDE_PERSONAL_INFO:
        return "개인정보 수집 및 이용 동의";
      case ETerms.LOCATION_BASED:
        return "위치기반 서비스 이용약관 동의";
      case ETerms.MARKETING:
        return "마케팅 정보 활용 동의";
      default:
        return "";
    }
  }

  bool get isRequired {
    switch (this) {
      case ETerms.TERMS_OF_USE:
        return true;
      case ETerms.CONSENT_TO_PROVIDE_PERSONAL_INFO:
        return true;
      case ETerms.LOCATION_BASED:
        return true;
      case ETerms.MARKETING:
        return false;
      default:
        return false;
    }
  }
}
