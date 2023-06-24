class LoginResponse {
  bool? status;
  String? message;
  bool? isEmployee;
  Employee? employee;
  User? user;
  String? authToken;

  LoginResponse(
      {this.status,
      this.message,
      this.isEmployee,
      this.employee,
      this.user,
      this.authToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isEmployee = json['isEmployee'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['isEmployee'] = isEmployee;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['authToken'] = authToken;
    return data;
  }
}

class Employee {
  String? id;
  String? name;
  String? phoneNumber;
  String? password;
  String? email;
  String? accessCode;
  String? role;
  String? address;
  String? createdBy;
  String? branch;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
      this.name,
      this.phoneNumber,
      this.password,
      this.email,
      this.accessCode,
      this.role,
      this.address,
      this.createdBy,
      this.branch,
      this.createdAt,
      this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    email = json['email'];
    accessCode = json['accessCode'];
    role = json['role'];
    address = json['address'];
    createdBy = json['createdBy'];
    branch = json['branch'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['email'] = email;
    data['accessCode'] = accessCode;
    data['role'] = role;
    data['address'] = address;
    data['createdBy'] = createdBy;
    data['branch'] = branch;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
