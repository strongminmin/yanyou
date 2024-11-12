class AdvisoryModel extends Object {
  int advisoryId;
  String advisoryTag;
  String advisoryTitle;
  String advisoryBanner;
  String advisoryContent;
  int advisoryAccess;
  String advisorySource;
  int advisoryReward;
  String createTime;
  AdvisoryModel({
    this.advisoryAccess,
    this.advisoryBanner,
    this.advisoryContent,
    this.advisoryId,
    this.advisoryReward,
    this.advisorySource,
    this.advisoryTag,
    this.advisoryTitle,
    this.createTime,
  });
  factory AdvisoryModel.fromJson(Map<String, dynamic> json) {
    return AdvisoryModel(
      advisoryId: json['advisory_id'] as int,
      advisoryTag: json['advisory_tag'] as String,
      advisoryBanner: json['advisory_banner'] as String,
      advisoryContent: json['advisory_content'] as String,
      advisoryAccess: json['advisory_access'] as int,
      advisoryTitle: json['advisory_title'] as String,
      advisoryReward: json['advisory_reward'] as int,
      createTime: json['create_time'] as String,
      advisorySource: json['advisory_source'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'advisory_id': advisoryId,
      'advisory_tag': advisoryTag,
      'advisory_banner': advisoryBanner,
      'advisory_content': advisoryContent,
      'advisory_access': advisoryAccess,
      'advisory_title': advisoryTitle,
      'advisory_reward': advisoryReward,
      'create_time': createTime,
      'advisory_source': advisorySource,
    };
  }
}
