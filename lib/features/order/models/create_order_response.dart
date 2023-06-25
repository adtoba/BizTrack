class CreateOrderResponse {
  bool? status;
  String? message;
  Data? data;

  CreateOrderResponse({this.status, this.message, this.data});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  List<Orders>? orders;
  String? paymentMethod;
  int? subtotal;
  String? customer;
  String? branch;
  String? userRole;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.orders,
      this.paymentMethod,
      this.subtotal,
      this.customer,
      this.branch,
      this.userRole,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    paymentMethod = json['paymentMethod'];
    subtotal = json['subtotal'];
    customer = json['customer'];
    branch = json['branch'];
    userRole = json['userRole'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['paymentMethod'] = paymentMethod;
    data['subtotal'] = subtotal;
    data['customer'] = customer;
    data['branch'] = branch;
    data['userRole'] = userRole;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Orders {
  String? id;
  String? productId;
  int? quantity;
  int? discount;
  String? createdAt;
  String? updatedAt;

  Orders(
      {this.id,
      this.productId,
      this.quantity,
      this.discount,
      this.createdAt,
      this.updatedAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantity = json['quantity'];
    discount = json['discount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['discount'] = discount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
