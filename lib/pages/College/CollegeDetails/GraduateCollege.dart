import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class GraduateCollege extends StatefulWidget {
  final String collegeName;
  GraduateCollege({Key key, this.collegeName}) : super(key: key);
  _GraduateCollegeState createState() => _GraduateCollegeState();
}

class _GraduateCollegeState extends State<GraduateCollege> {
  WebViewController _webViewcontroller;
  String title = '研究生院';
  void webViewFinishedHandler(url) {
    _webViewcontroller.evaluateJavascript('document.title').then((result) {
      setState(() {
        title = result.substring(1, result.length - 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          String url = collegeProvider
              .collegeDetailsModel.collegeGraduate['graduateUrl'][0][0];
          return WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted, //JS执行模式 是否允许JS执行
            onWebViewCreated: (controller) {
              _webViewcontroller = controller;
            },
            onPageFinished: webViewFinishedHandler,
          );
        },
      ),
    );
  }
}
