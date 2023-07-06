class CreateEmployeeResponse {
  bool? status;
  String? message;
  CreateEmployee? employee;

  CreateEmployeeResponse({this.status, this.message, this.employee});

  CreateEmployeeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    employee = json['data'] != null ? CreateEmployee.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (employee != null) {
      data['data'] = employee!.toJson();
    }
    return data;
  }
}

class CreateEmployee {
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

  CreateEmployee(
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

  CreateEmployee.fromJson(Map<String, dynamic> json) {
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
  Branch? branch;
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
    branch = json['branch'] != null
      ? Branch.fromJson(json['branch'])
      : null;
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

class CreatedBy {
  String? id;
  String? businessName;
  String? email;
  String? phoneNumber;
  String? role;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;

  CreatedBy(
      {this.id,
      this.businessName,
      this.email,
      this.phoneNumber,
      this.role,
      this.emailVerified,
      this.createdAt,
      this.updatedAt});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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

class Branch {
  String? id;
  String? name;

  Branch({
    this.id,
    this.name
  });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
  
}
