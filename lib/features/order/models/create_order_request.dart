class CreateOrderRequest {
  List<Orders>? orders;
  String? paymentMethod;
  double? subtotal;
  String? customer;
  String? customerName;
  String? cashier;
  String? cashierName;
  String? branch;
  double? discount;

  CreateOrderRequest(
      {this.orders,
      this.paymentMethod,
      this.subtotal,
      this.customer,
      this.customerName,
      this.branch,
      this.cashier,
      this.cashierName,
      this.discount});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    paymentMethod = json['paymentMethod'];
    subtotal = json['subtotal'];
    customer = json['customer'];
    customerName = json['customerName'];
    cashier = json['cashier'];
    cashierName = json['cashierName'];
    branch = json['branch'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['paymentMethod'] = paymentMethod;
    data['subtotal'] = subtotal;
    data['cashier'] = cashier;
    data['cashierName'] = cashierName;
    data['customer'] = customer;
    data['customerName'] = customerName;
    data['branch'] = branch;
    data['discount'] = discount;
    return data;
  }
}

class OrderCustomer {
  String? id;
  String? name;

  OrderCustomer({
    this.id,
    this.name
  });

  OrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class Cashier {
  String? id;
  String? name;

  Cashier({
    this.id,
    this.name
  });

  Cashier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class Orders {
  String? name;
  String? productId;
  double? total;
  int? quantity;
  int? discount;

  Orders({this.productId, this.quantity, this.discount, this.name, this.total});

  Orders.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    discount = json['discount'];
    total = json['total'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['total'] = total;
    data['discount'] = discount;
    data['name'] = name;
    return data;
  }
}
