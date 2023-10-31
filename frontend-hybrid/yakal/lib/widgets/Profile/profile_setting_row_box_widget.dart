import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileSettingRowBoxWidget extends StatelessWidget {
  final String text;
  final String? routerLinkText;

  const ProfileSettingRowBoxWidget({
    required this.text,
    required this.routerLinkText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          if (routerLinkText == "/certification") {
            // WebView 페이지로 이동
            Get.to(() => const WebviewWithWebviewFlutterScreen());
          } else {
            // 다른 페이지로 이동
            Get.toNamed(routerLinkText ?? "/profile");
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff151515),
                ),
              ),
              if (routerLinkText == null) const Spacer(),
              if (routerLinkText == null)
                const Text(
                  "1.0.0",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff90909F),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebviewWithWebviewFlutterScreen extends StatefulWidget {
  const WebviewWithWebviewFlutterScreen({super.key});

  @override
  State<WebviewWithWebviewFlutterScreen> createState() =>
      _WebviewWithWebviewFlutterScreenState();
}

class _WebviewWithWebviewFlutterScreenState
    extends State<WebviewWithWebviewFlutterScreen> {
  WebViewController? _webViewController;
  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://yakal.dcs-hyungjoon.com/'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('전문가 인증')),
      body: WebViewWidget(controller: _webViewController!),
    );
  }
}
