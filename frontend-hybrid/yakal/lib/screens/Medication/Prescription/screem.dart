import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yakal/screens/Medication/Prescription/children/first_page_error_indicator.dart';
import 'package:yakal/screens/Medication/Prescription/children/new_page_error_indicator.dart';
import 'package:yakal/screens/Medication/Prescription/children/no_items_found_indicator.dart';
import 'package:yakal/screens/Medication/Prescription/children/no_more_items_indicator.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/viewModels/Medication/prescription_view_model.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Medication/prescription_card.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final PrescriptionViewModel prescriptionViewModel = PrescriptionViewModel();

  @override
  void initState() {
    prescriptionViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    prescriptionViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorStyles.white,
          resizeToAvoidBottomInset: false,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: DefaultBackAppbar(
              title: '처방전 조회하기',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => prescriptionViewModel.pagingController.refresh(),
              ),
              child: PagedListView<int, int>.separated(
                pagingController: prescriptionViewModel.pagingController,
                builderDelegate: PagedChildBuilderDelegate<int>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => PrescriptionCard(
                    id: item,
                  ),
                  firstPageErrorIndicatorBuilder: (_) =>
                      FirstPageErrorIndicator(
                    onTryAgain: () =>
                        prescriptionViewModel.pagingController.refresh(),
                  ),
                  newPageErrorIndicatorBuilder: (_) => NewPageErrorIndicator(
                    onTryAgain: () => prescriptionViewModel.pagingController
                        .retryLastFailedRequest(),
                  ),
                  noItemsFoundIndicatorBuilder: (_) =>
                      const NoItemsFoundIndicator(),
                  noMoreItemsIndicatorBuilder: (_) =>
                      const NoMoreItemsIndicator(),
                  // <Loading Spinner Customizer>
                  // firstPageProgressIndicatorBuilder: (_) =>
                  //     FirstPageProgressIndicator(),
                  // newPageProgressIndicatorBuilder: (_) =>
                  //     NewPageProgressIndicator(),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
