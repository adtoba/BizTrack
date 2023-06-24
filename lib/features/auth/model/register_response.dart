class RegisterResponse {
  bool? status;
  String? message;
  User? data;

  RegisterResponse({this.status, this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? businessName;
  String? email;
  String? phoneNumber;
  String? role;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.businessName,
      this.email,
      this.phoneNumber,
      this.role,
      this.emailVerified,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    emailVerified = json['emailVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['businessName'] = businessName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['emailVerified'] = emailVerified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
