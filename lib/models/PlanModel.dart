class PlanModel extends Object {
  Map<String, List<Plan>> planModel = {};
  PlanModel({
    this.planModel,
  });
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<Plan>> tempPlanModel = {};
    json.keys.forEach((key) {
      List<Plan> plans = json[key]
          .map((item) {
            return Plan.fromJson(item);
          })
          .cast<Plan>()
          .toList();
      tempPlanModel[key] = plans;
    });
    return PlanModel(planModel: tempPlanModel);
  }
}

class Plan extends Object {
  int planId;
  int userId;
  int planMonth;
  String planContent;
  String createTime;
  Plan({
    this.planId,
    this.userId,
    this.planMonth,
    this.planContent,
    this.createTime,
  });
  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planId: json['plan_id'] as int,
      userId: json['user_id'] as int,
      planMonth: json['plan_month'] as int,
      planContent: json['plan_content'] as String,
      createTime: json['create_time'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'plan_id': planId,
      'user_id': userId,
      'plan_month': planMonth,
      'plan_content': planContent,
      'create_time': createTime,
    };
  }
}
