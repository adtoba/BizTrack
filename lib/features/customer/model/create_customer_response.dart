class CreateCustomerResponse {
  bool? status;
  String? message;
  Customer? data;

  CreateCustomerResponse({this.status, this.message, this.data});

  CreateCustomerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Customer.fromJson(json['data']) : null;
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

class Customer {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? address;
  String? createdBy;
  int? totalAmountPaid;
  int? totalAmountDue;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.address,
      this.createdBy,
      this.totalAmountPaid,
      this.totalAmountDue,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    createdBy = json['createdBy'];
    totalAmountPaid = json['totalAmountPaid'];
    totalAmountDue = json['totalAmountDue'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['createdBy'] = createdBy;
    data['totalAmountPaid'] = totalAmountPaid;
    data['totalAmountDue'] = totalAmountDue;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
