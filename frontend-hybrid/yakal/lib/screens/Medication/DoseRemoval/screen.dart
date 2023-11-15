import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yakal/provider/Medicine/dose_management_provider.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';
import 'package:yakal/widgets/Medication/dose_delete_dialog.dart';

class DoseRemovalScreen extends StatefulWidget {
  const DoseRemovalScreen({super.key});

  @override
  State<DoseRemovalScreen> createState() => _DoseRemovalScreenState();
}

class _DoseRemovalScreenState extends State<DoseRemovalScreen> {
  late int prescriptionId;

  final DoseManagementProvider doseManagementProvider =
      DoseManagementProvider();

  @override
  void initState() {
    super.initState();
    prescriptionId = Get.arguments["id"] as int;
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
              title: '복용 스케줄 조회하기',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: FutureBuilder(
              future: doseManagementProvider.getDoseList(prescriptionId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final doseList = snapshot.data as List;

                return ListView.separated(
                  itemCount: doseList.length,
                  itemBuilder: (context, index) {
                    final modificationElement = doseList[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 32,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: ColorStyles.gray2,
                                  ),
                                  child:
                                      // modificationElement.base64Image.isNotEmpty
                                      //     ? Image.memory(
                                      //         base64Decode(
                                      //           modificationElement
                                      //               .item.base64Image,
                                      //         ),
                                      //         fit: BoxFit.cover,
                                      //       )
                                      SvgPicture.asset(
                                    "assets/icons/img-mainpill-default.svg",
                                    width: 64,
                                    height: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  modificationElement["name"],
                                  style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              padding: const EdgeInsets.all(0.0),
                              icon: SvgPicture.asset(
                                "assets/icons/icon-bin.svg",
                                width: 20,
                                height: 20,
                              ),
                              color: ColorStyles.main,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierColor:
                                      const Color.fromRGBO(98, 98, 114, 0.4),
                                  builder: (BuildContext context) {
                                    return DoseDeleteDialog(
                                      id: modificationElement["id"],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
