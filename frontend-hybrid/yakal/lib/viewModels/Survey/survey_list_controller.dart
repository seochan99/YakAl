import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/utilities/api/api.dart';

class SurveyListController extends GetxController {
  final List<SurveyModel> tests;

  SurveyListController({required this.tests});

  @override
  void onInit() {
    super.onInit();
    updateAllSurveysCompletionStatus();
  }

  Future<void> updateAllSurveysCompletionStatus() async {
    var dio = await authDioWithContext();
    try {
      var response = await dio.get("/surveys/answers");
      if (response.statusCode == 200) {
        List dataList = response.data['data']['result'];
        for (var survey in tests) {
          var matchingData = dataList.firstWhere(
            (data) => data['title'] == survey.title,
            orElse: () => null,
          );
          survey.isCompleted =
              dataList.any((data) => data['title'] == survey.title);

          if (survey.isCompleted) {
            survey.resultComment = matchingData['resultComment'];
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
