class GetBranchResponse {
  bool? status;
  String? message;
  List<Branch>? branch;

  GetBranchResponse({this.status, this.message, this.branch});

  GetBranchResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      branch = <Branch>[];
      json['data'].forEach((v) {
        branch!.add(Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (branch != null) {
      data['data'] = branch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branch {
  String? id;
  String? name;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Branch({this.id, this.name, this.createdBy, this.createdAt, this.updatedAt});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
