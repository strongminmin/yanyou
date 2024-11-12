import 'dart:convert';

class CollegeModel extends Object {
  Map<String, List<dynamic>> collegeMap;
  CollegeModel({this.collegeMap});
  factory CollegeModel.fromJson(List<dynamic> json) {
    Map<String, List<dynamic>> tempCollegeMap = {};
    json.forEach((item) {
      if (tempCollegeMap.containsKey(item['college_local'])) {
        tempCollegeMap[item['college_local']].add(item);
      } else {
        tempCollegeMap[item['college_local']] = [item];
      }
    });
    return CollegeModel(collegeMap: tempCollegeMap);
  }
}

class CollegeDetailsModel extends Object {
  int collegeId;
  String collegeName;
  String collegeLocal;
  String collegeIntor;
  String collegeBanner;
  Map collegeGraduate;
  CollegeDetailsModel({
    this.collegeId,
    this.collegeName,
    this.collegeLocal,
    this.collegeGraduate,
    this.collegeIntor,
    this.collegeBanner,
  });
  factory CollegeDetailsModel.fromJson(Map<String, dynamic> json) {
    return CollegeDetailsModel(
      collegeId: json['college_id'] as int,
      collegeName: json['college_name'] as String,
      collegeLocal: json['college_local'] as String,
      collegeIntor: json['college_intor'] as String,
      collegeBanner: json['college_banner'] as String,
      collegeGraduate: jsonDecode(json['college_graduate']) as Map,
    );
  }
}
