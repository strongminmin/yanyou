class HistoryModel extends Object {
  int historyId;
  int userId;
  String historyContent;
  String createTime;
  HistoryModel({
    this.historyId,
    this.userId,
    this.historyContent,
    this.createTime,
  });
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      historyId: json['history_id'] as int,
      userId: json['user_id'] as int,
      historyContent: json['history_content'] as String,
      createTime: json['create_time'] as String,
    );
  }
}
