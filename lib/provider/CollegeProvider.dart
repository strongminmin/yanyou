import 'package:flutter/material.dart';
import 'package:yanyou/models/CollegeModel.dart';

class CollegeProvider extends ChangeNotifier {
  CollegeDetailsModel collegeDetailsModel;
  init(Map<String, dynamic> json) {
    CollegeDetailsModel tempModel = CollegeDetailsModel.fromJson(json);
    this.collegeDetailsModel = tempModel;
    notifyListeners();
  }
}
