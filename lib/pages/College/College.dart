import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Collgeg.dart';
import 'package:yanyou/components/College/CityDrawer.dart';
import 'package:yanyou/models/CollegeModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';
import 'package:yanyou/routes/Application.dart';
import 'package:yanyou/routes/Routes.dart';

class College extends StatefulWidget {
  _CollegeState createState() => _CollegeState();
}

class _CollegeState extends State<College> {
  Map<String, List<dynamic>> collegeModel;
  void cityChangeHandler(String city) {
    setState(() {
      colleges = collegeModel[city];
    });
    Navigator.of(context).pop();
  }

  List<dynamic> colleges = [];
  @override
  void initState() {
    super.initState();
    fetchRequest();
  }

  Future<void> fetchRequest() async {
    try {
      var result = await getCollegeList();
      print(result);
      if (result['noerr'] == 0) {
        Map<String, List<dynamic>> tempCollege =
            CollegeModel.fromJson(result['data']).collegeMap;
        print(tempCollege);
        setState(() {
          collegeModel = tempCollege;
          colleges = tempCollege[tempCollege.keys.toList()[0]];
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Function jumpCollegeDetails(Map college) {
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
          '${Routes.collegeDetailsPage}?collegeId=${college['college_id']}',
          transition: TransitionType.native,
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return collegeModel == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('院校'),
              centerTitle: true,
            ),
            drawer: CityDrawer(
              citys: collegeModel.keys.toList(),
              changeHandler: cityChangeHandler,
            ),
            body: Container(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                  childAspectRatio: 3,
                ),
                itemCount: colleges.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: jumpCollegeDetails(colleges[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          colleges[index]['college_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[300],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
