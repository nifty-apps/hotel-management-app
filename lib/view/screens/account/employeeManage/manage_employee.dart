import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/employee.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/provider/employee.dart';
import 'package:hotel_management/routes.dart';
import 'package:shimmer/shimmer.dart';

class ManageEmployeeScreen extends ConsumerStatefulWidget {
  const ManageEmployeeScreen({super.key});

  @override
  ConsumerState<ManageEmployeeScreen> createState() =>
      _ManageEmployeeScreenState();
}

class _ManageEmployeeScreenState extends ConsumerState<ManageEmployeeScreen> {
  @override
  Widget build(BuildContext contextf) {
    final provider = ref.read(employeeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Employee'),
      ),
      floatingActionButton: ref.read(authProvider).userData!.role == 'Owner'
          ? FloatingActionButton(
              onPressed: () {
                Employee employee = Employee(
                  id: null,
                  name: null,
                  email: null,
                  role: null,
                  phone: null,
                  address: null,
                );
                Navigator.pushNamed(context, Routes.addEmployee,
                        arguments: employee)
                    .then((_) {
                  setState(() {});
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : SizedBox(),
      body: FutureBuilder(
        future: provider.getEmployeeList(),
        builder: (context, AsyncSnapshot<List<Employee>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Employee> employees = snapshot.data ?? [];
            if (employees.length == 0) {
              return Center(
                child: Text('No Employee Found'),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Accounts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Divider(
                            color: Theme.of(context).colorScheme.background,
                            thickness: 1,
                          ),
                          ListTile(
                            onTap: () {
                              Employee employee = Employee(
                                id: employees[index].id,
                                name: employees[index].name,
                                email: employees[index].email,
                                role: employees[index].role,
                                phone: employees[index].phone,
                                address: employees[index].address,
                              );
                              Navigator.pushNamed(context, Routes.addEmployee,
                                      arguments: employee)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                            leading: Icon(Icons.person),
                            title: Text(employees[index].name.toString()),
                            subtitle: Text(employees[index].phone.toString()),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return shimmerWidget(context);
        },
      ),
    );
  }

  Widget shimmerWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            child: Container(height: 5, width: 200, color: Colors.grey),
            baseColor: Theme.of(context).colorScheme.background,
            highlightColor: Theme.of(context).highlightColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.background,
                    highlightColor: Theme.of(context).highlightColor,
                    child: Divider(
                      color: Theme.of(context).colorScheme.background,
                      thickness: 1,
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.background,
                    highlightColor: Theme.of(context).highlightColor,
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.background),
                      ),
                      title: Container(
                        height: 10,
                        width: 300,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      subtitle: Container(
                        height: 5,
                        width: 200,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
