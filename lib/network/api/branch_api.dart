import 'package:biz_track/features/branch/models/get_branch_response.dart';
import 'package:biz_track/network/api_client.dart';
import 'package:biz_track/network/endpoints.dart';
import 'package:dio/dio.dart';

class BranchApi extends ApiClient {
  Future<Response?> createBranch({String? name}) async {
    final res = await http.post(AppEndpoints.branch, data: {
      "name": name
    });

    return res;
  }

  Future<GetBranchResponse?> getBranches() async {
    final res = await http.get(AppEndpoints.branch);

    return GetBranchResponse.fromJson(res.data);
  }

  Future<Branch?> getBranchById({String? branchId}) async {
    final res = await http.get("${AppEndpoints.branch}/$branchId");

    return Branch.fromJson(res.data['data']);
  }
}