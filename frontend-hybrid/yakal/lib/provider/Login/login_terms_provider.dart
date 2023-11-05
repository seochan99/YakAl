import 'package:flutter/services.dart' show rootBundle;
import 'package:yakal/utilities/enum/terms.dart';

class LoginTermsProvider {
  Future<String> loadAsset(ETerms terms) async {
    return await rootBundle.loadString('assets/data/${terms.fileName}.txt');
  }
}
