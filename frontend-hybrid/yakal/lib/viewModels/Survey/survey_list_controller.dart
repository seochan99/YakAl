import 'package:get/get.dart';
import 'package:yakal/models/Survey/survey_model.dart';
import 'package:yakal/utilities/api/api.dart';

class SurveyListController extends GetxController {
  // 테스트 목록 (이전 코드에서 가져옴)
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
      var response = await dio.get("/survey/answer");
      if (response.statusCode == 200) {
        List dataList = response.data['data']['datalist'];
        for (var survey in tests) {
          survey.isCompleted =
              dataList.any((data) => data['title'] == survey.title);
        }
        update();
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
