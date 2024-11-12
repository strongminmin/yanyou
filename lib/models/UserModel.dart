class UserModel extends Object {
  int userId;
  String userName;
  String userEmail;
  String password;
  String userImage;
  String userDescription;
  String volunteerSchool;
  String volunteerProfession;
  String userSex;
  String userBirthday;
  int userStatus;
  UserModel({
    this.userId,
    this.userName,
    this.userImage =
        'http://kimvoice.oss-cn-beijing.aliyuncs.com/voice/user/2020-03-08%2013%3A41%3A21.065889.jpg',
    this.password,
    this.userBirthday,
    this.userDescription,
    this.userEmail,
    this.userSex,
    this.userStatus,
    this.volunteerProfession = '暂无',
    this.volunteerSchool = '暂无',
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as int,
      userImage: json['user_image'] as String,
      userBirthday: json['user_birthday'] as String,
      userDescription: json['user_description'] as String,
      userEmail: json['user_email'] as String,
      userName: json['user_name'] as String,
      userSex: json['user_sex'] as String,
      userStatus: json['user_status'] as int,
      password: json['user_password'] as String,
      volunteerProfession: json['volunteer_profession'] as String,
      volunteerSchool: json['volunteer_school'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'user_image': userImage,
      'user_birthday': userBirthday,
      'user_description': userDescription,
      'user_email': userEmail,
      'user_name': userName,
      'user_sex': userSex,
      'user_status': userStatus,
      'user_password': password,
      'volunteer_profession': volunteerProfession,
      'volunteer_school': volunteerSchool,
    };
  }
}
