import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/provider/bookings.dart';
import 'package:hotel_management/view/base/search_text_form_field.dart';
import 'package:shimmer/shimmer.dart';

class CustomerListScreen extends ConsumerWidget {
  CustomerListScreen({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      hintText: 'Phone',
                      onTap: () {
                        ref
                            .watch(bookingProvider)
                            .getListOfCustomer(searchController.text.trim());
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ref.watch(bookingProvider).isLoading
                ? shimmerWidget(context)
                : Flexible(
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
                      child:
                          ref.watch(bookingProvider).listOfCustomer.length == 0
                              ? Center(
                                  child: Text(
                                    'No customer found!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : Column(
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
                                        itemCount: ref
                                            .watch(bookingProvider)
                                            .listOfCustomer
                                            .length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            Divider(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              thickness: 3,
                                            ),
                                            ListTile(
                                              // onTap: () => Navigator.pushNamed(
                                              //     context, Routes.addRoom,
                                              //     arguments: true),
                                              leading: Icon(
                                                Icons.person,
                                                size: 40,
                                              ),
                                              trailing: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              title: Text(ref
                                                  .read(bookingProvider)
                                                  .listOfCustomer[index]
                                                  .customer
                                                  .name),
                                              subtitle: Text(ref
                                                  .read(bookingProvider)
                                                  .listOfCustomer[index]
                                                  .customer
                                                  .phone),
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

  Widget shimmerWidget(BuildContext context) {
    return Flexible(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.background,
                highlightColor: Theme.of(context).highlightColor,
                child: Container(
                  height: 10,
                  width: 40,
                  color: Theme.of(context).colorScheme.background,
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
                    Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.background,
                      highlightColor: Theme.of(context).highlightColor,
                      child: ListTile(
                        // onTap: () => Navigator.pushNamed(
                        //     context, Routes.addRoom,
                        //     arguments: true),
                        leading: Container(
                          height: 40,
                          width: 40,
                          color: Theme.of(context).colorScheme.background,
                        ),

                        title: Container(
                          height: 10,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        subtitle: Container(
                          height: 10,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
