import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yanyou/models/ResourceModel.dart';

class ResourceItem extends StatelessWidget {
  final Resource resourceModel;
  ResourceItem({Key key, this.resourceModel}) : super(key: key);
  Function callCoundDisk(BuildContext context, String url) {
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
    return GestureDetector(
      onTap: callCoundDisk(context, resourceModel.resourceUrl),
      child: Container(
        width: screenWidth,
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              resourceModel.resourceTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                '链接：${resourceModel.resourceUrl}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                '密钥：${resourceModel.resourceIdent}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
