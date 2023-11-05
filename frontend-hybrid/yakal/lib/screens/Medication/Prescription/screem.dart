import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yakal/utilities/api/api.dart';
import 'package:yakal/utilities/style/color_styles.dart';
import 'package:yakal/widgets/Base/default_back_appbar.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final int LIMIT = 18;

  late ScrollController _controller;

  int _page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _prescriptionList = [];

  void _initLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final dio = await authDioWithContext();
      final response = await dio.get("${dotenv.env['YAKAL_SERVER_HOST']}");

      setState(() {
        _prescriptionList = List.from(response.data);
      });
    } catch (e) {
      _prescriptionList = [];
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _nextLoad() async {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        final dio = await authDioWithContext();
        final response = await dio.get("${dotenv.env['YAKAL_SERVER_HOST']}");
        final List fetchedPrescription = json.decode(response.data);

        setState(() {
          _prescriptionList.addAll(fetchedPrescription);
        });

        if (fetchedPrescription.isNotEmpty) {
          setState(() {
            _prescriptionList.addAll(fetchedPrescription);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        _prescriptionList = [];
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _initLoad();
    _controller = ScrollController()..addListener(_nextLoad);
  }

  @override
  void dispose() {
    _controller.removeListener(_nextLoad);
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
            child: _isFirstLoadRunning
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _controller,
                          itemCount: _prescriptionList.length,
                          itemBuilder: (context, index) => Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 60,
                              height: 30,
                              child: Text(
                                _prescriptionList[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_isLoadMoreRunning)
                        Container(
                          padding: const EdgeInsets.all(30),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (!_hasNextPage)
                        Container(
                          padding: const EdgeInsets.all(20),
                          color: ColorStyles.sub1,
                          child: const Center(
                            child: Text(
                              "No More Data",
                              style: TextStyle(
                                color: ColorStyles.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
