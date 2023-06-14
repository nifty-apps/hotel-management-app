// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/employee.dart';
import 'package:hotel_management/provider/auth_provider.dart';
import 'package:hotel_management/provider/employee.dart';
import 'package:hotel_management/view/base/custom_button.dart';
import 'package:hotel_management/view/base/text_form_field.dart';

class EmployeeAddScreen extends ConsumerWidget {
  final Employee employee;
  EmployeeAddScreen({
    required this.employee,
  });
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void setInfo() {
    if (employee.id != null) {
      nameController.text = employee.name ?? '';
      emailController.text = employee.email ?? '';
      phoneController.text = employee.phone ?? '';
      addressController.text = employee.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.id != null ? 'Employee info' : 'Add Employee'),
        actions: [
          if (employee.id != null)
            if (ref.read(authProvider).userData!.role == 'Owner')
              IconButton(
                onPressed: () {
                  ref
                      .read(employeeProvider.notifier)
                      .deleteAccount(id: employee.id!, context: context);

                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete),
              ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Consumer(
        builder: (context, ref, _) {
          final provider = ref.watch(employeeProvider);
          return Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.background,
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'Name',
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      labelText: 'Email',
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: 'Phone',
                      labelText: 'Phone',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: addressController,
                      hintText: 'Address',
                      labelText: 'Address',
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.location_on,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 200),
                    CustomButton(
                      onPressed: () async {
                        if (employee.id != null) {
                          Employee updateEmployee = Employee(
                            id: employee.id,
                            name: nameController.text,
                            email: emailController.text,
                            role: 'Employee',
                            phone: phoneController.text,
                            address: addressController.text,
                          );
                          bool isSuccess = await provider.updateEmployee(
                            updateEmployee,
                            passwordController.text.trim(),
                            context,
                          );
                          if (isSuccess) {
                            Navigator.pop(context);
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            Employee employee = Employee(
                              name: nameController.text,
                              email: emailController.text,
                              role: 'Employee',
                              phone: phoneController.text,
                              address: addressController.text,
                            );
                            bool isSuccess = await provider.addEmployee(
                              employee,
                              passwordController.text.trim(),
                              context,
                            );
                            if (isSuccess) {
                              await ref
                                  .read(employeeProvider)
                                  .getEmployeeList();
                              Navigator.pop(context);
                            }
                          }
                        }
                      },
                      buttonText: employee.id != null ? 'Save' : 'Add Employee',
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
