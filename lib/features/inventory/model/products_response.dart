class ProductsResponse {
  bool? status;
  String? message;
  List<Product>? products;

  ProductsResponse({this.status, this.message, this.products});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      products = <Product>[];
      json['data'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? sellingPrice;
  String? category;
  String? image;
  String? purchasePrice;
  String? branch;
  int? stockCount;
  String? barCode;
  String? createdBy;
  String? userRole;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.sellingPrice,
      this.category,
      this.image,
      this.purchasePrice,
      this.branch,
      this.stockCount,
      this.barCode,
      this.createdBy,
      this.userRole,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellingPrice = json['sellingPrice'];
    category = json['category'];
    image = json['image'];
    purchasePrice = json['purchasePrice'];
    branch = json['branch'];
    stockCount = json['stockCount'];
    barCode = json['barCode'];
    createdBy = json['createdBy'];
    userRole = json['userRole'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sellingPrice'] = sellingPrice;
    data['category'] = category;
    data['image'] = image;
    data['purchasePrice'] = purchasePrice;
    data['branch'] = branch;
    data['stockCount'] = stockCount;
    data['barCode'] = barCode;
    data['createdBy'] = createdBy;
    data['userRole'] = userRole;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
