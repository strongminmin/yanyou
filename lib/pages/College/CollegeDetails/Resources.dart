import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yanyou/provider/CollegeProvider.dart';

class Resources extends StatefulWidget {
  final String collegeName;
  Resources({Key key, this.collegeName}) : super(key: key);
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  List<Map> courceResources = [
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        },
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        },
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
    {
      'cource': '数据结构',
      'resource': [
        {
          'url': 'https://pan.baidu.com/s/1_JgZFUTxgyHbFtLIJpy4pA',
          'ident': 'fi1t',
        }
      ]
    },
  ];

  Function callCoundDisk(String url) {
    return () async {
      try {
        var result = await launch(url);
        if (!result) {
          Toast.show(
            '打开百度网盘失败，请自行粘贴地址到浏览器中打开',
            context,
            duration: Toast.LENGTH_LONG,
          );
        }
        print(result);
      } catch (err) {
        print(err);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('真题资料'),
        centerTitle: true,
      ),
      body: Consumer<CollegeProvider>(
        builder: (context, collegeProvider, child) {
          List courceResources =
              collegeProvider.collegeDetailsModel.collegeGraduate['resources'];
          return Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.blue[100],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contentWidget(courceResources),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> contentWidget(List courceResources) {
    return courceResources
        .map((resource) {
          return Container(
            color: Colors.blue[100],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    resource[0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: callCoundDisk(resource[1]),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: SelectableText(
                              '链接：${resource[1]}',
                            ),
                          ),
                          SelectableText('密码：${resource[2]}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        })
        .cast<Widget>()
        .toList();
  }
}
