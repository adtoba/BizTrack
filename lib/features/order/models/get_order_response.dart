class GetOrderResponse {
  bool? status;
  String? message;
  List<Data>? data;

  GetOrderResponse({this.status, this.message, this.data});

  GetOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<Orders>? orders;
  String? paymentMethod;
  int? subtotal;
  String? cashier;
  String? cashierName;
  String? customer;
  String? customerName;
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
      this.cashier,
      this.cashierName,
      this.customerName,
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
    cashier = json['cashier'];
    cashierName = json['cashierName'];
    customerName = json['customerName'];
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
    data['customerName'] = customerName;
    data['cashier'] = cashier;
    data['cashierName'] = cashierName;
    data['branch'] = branch;
    data['userRole'] = userRole;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Orders {
  String? name;
  String? id;
  String? productId;
  int? quantity;
  int? discount;
  double? total;
  String? createdAt;
  String? updatedAt;

  Orders(
      {this.id,
      this.name,
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
    total = double.parse(json['total'].toString());
    updatedAt = json['updatedAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['discount'] = discount;
    data['total'] = total;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    return data;
  }
}
