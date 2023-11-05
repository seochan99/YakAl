import 'package:flutter/services.dart' show rootBundle;
import 'package:yakal/utilities/enum/terms_name.dart';

class LoginTermsProvider {
  Future<String> loadAsset(ETerms termsName) async {
    return await rootBundle.loadString('assets/data/${termsName.title}.txt');
  }
}
