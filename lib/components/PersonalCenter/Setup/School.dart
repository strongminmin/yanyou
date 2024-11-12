import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:yanyou/api/User.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class School extends StatefulWidget {
  final UserModel userModel;
  School({Key key, this.userModel}) : super(key: key);
  _SchoolState createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  bool isEdit = false;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.userModel.volunteerSchool,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController?.dispose();
  }

  void updateSchool() {
    setState(() {
      isEdit = true;
    });
  }

  void submitNewSchool() async {
    try {
      String value = _textEditingController.text;
      if (value == '') {
        Toast.show(
          '报考学校不能为空',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.CENTER,
        );
        return;
      }
      var result = await updateUserInfo(
        userId: widget.userModel.userId,
        key: 'volunteer_school',
        value: value,
      );
      if (result['noerr'] == 0) {
        await Provider.of<UserProvider>(context, listen: false).setUserMessage(
          'school',
          result['data'],
        );
      }
      setState(() {
        isEdit = false;
      });
      Toast.show(
        result['message'],
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.CENTER,
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: updateSchool,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '报考院校：',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.6,
                    child: isEdit
                        ? TextField(
                            controller: _textEditingController,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffix: GestureDetector(
                                onTap: submitNewSchool,
                                child: Text(
                                  '提交',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red[400],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            widget.userModel.volunteerSchool,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            isEdit
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isEdit = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[400],
                    ),
                  )
                : Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey[400],
                  ),
          ],
        ),
      ),
    );
  }
}
