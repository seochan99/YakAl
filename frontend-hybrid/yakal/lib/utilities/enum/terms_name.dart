enum ETerms {
  TERMS_OF_USE;
}

extension ETermsExtension on ETerms {
  String get fileName {
    switch (this) {
      case ETerms.TERMS_OF_USE:
        return "terms_of_use";
      default:
        return "";
    }
  }

  String get title {
    switch (this) {
      case ETerms.TERMS_OF_USE:
        return "서비스 이용약관";
      default:
        return "";
    }
  }
}
