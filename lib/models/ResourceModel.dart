class ResourceModel extends Object {
  Map<String, List<Resource>> resourceModel;
  ResourceModel({
    this.resourceModel,
  });
  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<Resource>> tempResourceModel = {};
    json.keys.forEach((key) {
      List<Resource> rsourceModels = json[key]
          .map((item) {
            return Resource.fromJson(item);
          })
          .cast<Resource>()
          .toList();
      tempResourceModel[key] = rsourceModels;
    });
    return ResourceModel(resourceModel: tempResourceModel);
  }
}

class Resource extends Object {
  int resourceId;
  String resourceType;
  String resourceTitle;
  String resourceUrl;
  String resourceIdent;
  Resource({
    this.resourceId,
    this.resourceType,
    this.resourceTitle,
    this.resourceIdent,
    this.resourceUrl,
  });
  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      resourceId: json['resource_id'] as int,
      resourceTitle: json['resource_title'] as String,
      resourceType: json['resource_type'] as String,
      resourceIdent: json['resource_ident'] as String,
      resourceUrl: json['resource_url'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'resource_id': resourceId,
      'resource_title': resourceTitle,
      'resource_type': resourceType,
      'resource_ident': resourceIdent,
      'resource_url': resourceUrl,
    };
  }
}
