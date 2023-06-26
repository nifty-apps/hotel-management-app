import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/helper/snacbar.dart';
import 'package:hotel_management/models/employee.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class EmployeeProvider with ChangeNotifier {
  final Ref ref;
  EmployeeProvider({required this.ref});

  bool isLoading = false;

  List<Employee> _employees = [];
  List<Employee> get employees => _employees;

  Future<bool> addEmployee(
      Employee employee, String password, BuildContext context) async {
    final response = await ref.read(apiClientProvider).post(AppConstants.user,
        data: {...employee.toMap(), 'password': password});

    if (response.statusCode == 201) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }

    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  Future<List<Employee>?> getEmployeeList() async {
    try {
      final response = await ref.read(apiClientProvider).get(AppConstants.user);

      if (response.statusCode == 200) {
        _employees = response.data['data'].map<Employee>((employee) {
          print(employee);
          return Employee.fromMap(employee);
        }).toList();
        notifyListeners();
        return _employees;
      }
    } catch (error) {
      print(error);
    }

    return null;
  }

  Future<bool> updateEmployee(
    Employee employee,
    String password,
    BuildContext context,
  ) async {
    final response = await ref
        .read(apiClientProvider)
        .put(AppConstants.user + '/${employee.id}', data: {
      ...employee.toMap(),
      if (password.isNotEmpty) 'password': password,
    });

    if (response.statusCode == 200) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      return true;
    }

    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }

  Future<bool> deleteAccount(
      {required String id, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final response =
        await ref.read(apiClientProvider).delete(AppConstants.user + '/$id');
    if (response.statusCode == 200) {
      final message = response.data['message'];
      showSnackBarMethod(context, message, true);
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    final message = response.data['message'];
    showSnackBarMethod(context, message, false);
    return false;
  }
}

final employeeProvider =
    ChangeNotifierProvider((ref) => EmployeeProvider(ref: ref));
