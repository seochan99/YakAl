import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../global/style/color_styles.dart';

class IdentificationCancelWebView extends StatefulWidget {
  const IdentificationCancelWebView({super.key});

  @override
  State<IdentificationCancelWebView> createState() =>
      _IdentificationCancelWebViewState();
}

class _IdentificationCancelWebViewState
    extends State<IdentificationCancelWebView> {
  final GlobalKey webViewKey = GlobalKey();
  Uri myUrl = Uri.parse("https://yakal/mobile/identify/cancel");
  late final InAppWebViewController webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white,
      child: SafeArea(
        child: Scaffold(
          body: InAppWebView(
            key: webViewKey,
            onLoadStart: (InAppWebViewController controller, Uri? uri) {
              print("webview is executed?");
              if (uri?.path == "https://yakal/mobile/identify/cancel") {
                print("webview is executed!");
                webViewController.goBack();
                Get.back();
              }
            },
          ),
        ),
      ),
    );
  }
}
