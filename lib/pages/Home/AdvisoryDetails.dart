import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Advisory.dart';
import 'package:yanyou/components/Home/Reward.dart';
import 'package:yanyou/models/AdvisoryModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class AdvisoryDetails extends StatefulWidget {
  final int advisoryId;
  AdvisoryDetails({Key key, this.advisoryId}) : super(key: key);
  _AdvisoryDetailsState createState() => _AdvisoryDetailsState();
}

class _AdvisoryDetailsState extends State<AdvisoryDetails> {
  AdvisoryModel advisoryModel;
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getAdvisoryDetails(
        userId: userModel.userId,
        advisoryId: widget.advisoryId,
      );
      if (result['noerr'] == 0) {
        AdvisoryModel tempAdvisoryModel = AdvisoryModel.fromJson(
          result['data'],
        );
        setState(() {
          advisoryModel = tempAdvisoryModel;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Function showRewardSheet(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Reward(advisoryId: advisoryModel.advisoryId);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('热点详情'),
        centerTitle: true,
      ),
      body: advisoryModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: screenWidth,
              height: screenHeight,
              padding: EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  advisoryHander(screenWidth),
                  advisoryContent(screenWidth),
                  reward(),
                ],
              ),
            ),
    );
  }

  Widget advisoryHander(num screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        advisoryBanner(screenWidth),
        advisoryTitle(),
        advisorySub(),
      ],
    );
  }

  Widget advisoryBanner(num screenWidth) {
    return Container(
      width: screenWidth,
      height: 140,
      child: CachedNetworkImage(
        width: screenWidth,
        height: 140,
        fit: BoxFit.cover,
        imageUrl: advisoryModel.advisoryBanner,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget advisoryTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        advisoryModel.advisoryTitle,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget advisorySub() {
    TextStyle style = TextStyle(
      fontSize: 13,
      color: Colors.grey,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('发布于${advisoryModel.createTime}', style: style),
          Text('${advisoryModel.advisoryAccess}人访问', style: style),
          Text('来源：${advisoryModel.advisorySource}', style: style),
        ],
      ),
    );
  }

  Widget advisoryContent(num screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 12),
      child: Html(data: advisoryModel.advisoryContent),
    );
  }

  Widget reward() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: showRewardSheet(context),
            child: Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/reward.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          Text('已经有${advisoryModel.advisoryReward}人打赏'),
        ],
      ),
    );
  }
}
