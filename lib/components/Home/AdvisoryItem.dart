import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/models/AdvisoryModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class AdvisoryItem extends StatelessWidget {
  final AdvisoryModel advisory;
  AdvisoryItem({Key key, this.advisory}) : super(key: key);
  Function jumpAdvisoryDetails(BuildContext context) {
    return () {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      if (userModel.userId == 0) {
        Application.router.navigateTo(
          context,
          Routes.loginPage,
          transition: TransitionType.native,
        );
      } else {
        Application.router.navigateTo(
          context,
          '${Routes.advisoryDetailsPage}?advisoryId=${advisory.advisoryId}',
          transition: TransitionType.native,
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: jumpAdvisoryDetails(context),
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.grey[200],
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            advisoryTitle(),
            advisoryContent(screenWidth),
          ],
        ),
      ),
    );
  }

  // 咨询标题
  Widget advisoryTitle() {
    String tag = advisory.advisoryTag.substring(0, 1);
    return Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              tag,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Text(advisory.advisoryTag),
      ],
    );
  }

  // 咨询内容
  Widget advisoryContent(screenWidth) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: 70,
                height: 70,
                imageUrl: advisory.advisoryBanner,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: screenWidth - 110,
                child: Text(
                  advisory.advisoryTitle,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              advisoryBottom(),
            ],
          ),
        ],
      ),
    );
  }

  // 咨询底部-发布时间以及访问量
  Widget advisoryBottom() {
    TextStyle textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );
    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          size: 14,
          color: Colors.grey,
        ),
        Text(
          advisory.createTime,
          style: textStyle,
        ),
        Container(
          margin: EdgeInsets.only(left: 12),
          child: Text(
            '${advisory.advisoryAccess}人访问',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
