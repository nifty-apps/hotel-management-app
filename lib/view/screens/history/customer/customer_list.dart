import 'package:flutter/material.dart';
import 'package:hotel_management/view/base/search_text_form_field.dart';

class CustomerListScreen extends StatelessWidget {
  CustomerListScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    SearchTextFormField(
                      controller: searchController,
                      hintText: 'Enter booking name or number',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        'Customer List',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Divider(
                              color: Theme.of(context).colorScheme.background,
                              thickness: 3,
                            ),
                            ListTile(
                              // onTap: () => Navigator.pushNamed(
                              //     context, Routes.addRoom,
                              //     arguments: true),
                              leading: Icon(Icons.person),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text('Abu Taher Mollah'),
                              subtitle: Text('01700000000'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
