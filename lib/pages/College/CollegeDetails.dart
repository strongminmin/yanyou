import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Collgeg.dart';
import 'package:yanyou/constants/index.dart';
import 'package:yanyou/models/CollegeModel.dart';
import 'package:yanyou/provider/CollegeProvider.dart';
import 'package:yanyou/routes/Application.dart';

class CollegeDetails extends StatefulWidget {
  final int collegeId;
  CollegeDetails({Key key, @required this.collegeId}) : super(key: key);
  _CollegeDetailsState createState() => _CollegeDetailsState();
}

class _CollegeDetailsState extends State<CollegeDetails> {
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      CollegeProvider collegeProvider = Provider.of<CollegeProvider>(
        context,
        listen: false,
      );
      var result = await getCollegeDetails(collegeId: widget.collegeId);
      if (result['noerr'] == 0) {
        collegeProvider.init(result['data']);
      }
    } catch (err) {
      print(err);
    }
  }

  Function jumpItemDetails(BuildContext context, index) {
    return () {
      String pagePath = collegeGrid[index]['page'];
      Application.router.navigateTo(
        context,
        '$pagePath',
        transition: TransitionType.native,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Consumer<CollegeProvider>(
      builder: (context, collegeProvider, child) {
        CollegeDetailsModel collegeDtailsModel =
            collegeProvider.collegeDetailsModel;
        return collegeDtailsModel == null
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(collegeDtailsModel.collegeName),
                  centerTitle: true,
                ),
                body: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      collegeBanner(screenWidth, collegeDtailsModel),
                      collegeContent(screenWidth, collegeDtailsModel),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget collegeBanner(
    num screenWidth,
    CollegeDetailsModel collegeDtailsModel,
  ) {
    return Container(
      width: screenWidth,
      height: 200,
      child: CachedNetworkImage(
        width: screenWidth,
        height: 200,
        fit: BoxFit.cover,
        imageUrl: collegeDtailsModel.collegeBanner,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget collegeContent(
    num screenWidth,
    CollegeDetailsModel collegeDtailsModel,
  ) {
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 16),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
        ),
        itemCount: collegeGrid.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: jumpItemDetails(context, index),
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    collegeGrid[index]['url'],
                    width: 40,
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      collegeGrid[index]['text'],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
