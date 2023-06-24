import 'package:biz_track/features/customer/model/create_customer_response.dart';
import 'package:biz_track/features/customer/model/customers_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';

class CustomerApi extends ApiClient {

  Future<CreateCustomerResponse?> createCustomer({
    String? name,
    String? phoneNumber,
    String? email,
    String? address
  }) async {
    final res = await http.post(AppEndpoints.customer, data: {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address
    });
    return CreateCustomerResponse.fromJson(res.data);
  }

  Future<CreateCustomerResponse?> getCustomer({String? id}) async {
    final res = await http.get("${AppEndpoints.customer}/$id");
    return CreateCustomerResponse.fromJson(res.data);
  }

  Future<CustomersResponse?> getCustomers() async {
    final res = await http.get(AppEndpoints.customer);
    return CustomersResponse.fromJson(res.data);
  }

  Future<void> deleteCustomer({String? id}) async {
    await http.delete("${AppEndpoints.customer}/$id");
  }

}