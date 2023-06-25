class CreateOrderRequest {
  List<Orders>? orders;
  String? paymentMethod;
  double? subtotal;
  String? customer;
  String? branch;
  double? discount;

  CreateOrderRequest(
      {this.orders,
      this.paymentMethod,
      this.subtotal,
      this.customer,
      this.branch,
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
    data['customer'] = customer;
    data['branch'] = branch;
    data['discount'] = discount;
    return data;
  }
}

class Orders {
  String? productId;
  int? quantity;
  int? discount;

  Orders({this.productId, this.quantity, this.discount});

  Orders.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['discount'] = discount;
    return data;
  }
}
