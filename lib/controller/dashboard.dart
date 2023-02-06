import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/dashboard.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class DashboardProvider extends ChangeNotifier {
  final Ref ref;

  DashboardProvider(this.ref);

  late DashboardInfo dashboardInfo;

  Future<DashboardInfo?> getDashboardInfo(String hotelId) async {
    final response =
        await ref.read(apiClientProvider).get('${AppConstants.dashboardInfo}/dashboard/$hotelId/info');
    if (response.statusCode == 200) {
      print(response.data);
      dashboardInfo = DashboardInfo.fromMap(response.data["data"]);
      print(dashboardInfo);
      notifyListeners();
      return dashboardInfo;
    }
    return null;
  }
}

final dashboardProvider =
    ChangeNotifierProvider((ref) => DashboardProvider(ref));
