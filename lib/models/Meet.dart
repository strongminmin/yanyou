class MeetModel extends Object {
  int meetId;
  String meetTitle;
  String meetContent;
  int meetAccess;
  String createTime;
  MeetModel({
    this.meetId,
    this.meetTitle,
    this.meetContent,
    this.meetAccess,
    this.createTime,
  });
  factory MeetModel.fromJson(Map<String, dynamic> json) {
    return MeetModel(
      meetId: json['meet_id'] as int,
      meetTitle: json['meet_title'] as String,
      meetContent: json['meet_content'] as String,
      meetAccess: json['meet_access'] as int,
      createTime: json['create_time'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'meet_id': meetId,
      'meet_title': meetTitle,
      'meet_content': meetContent,
      'meet_access': meetAccess,
      'create_time': createTime,
    };
  }
}
