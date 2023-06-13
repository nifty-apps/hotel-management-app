// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/routes.dart';
import 'package:hotel_management/services/local_strorage.dart';
import 'package:hotel_management/view/base/custom_button.dart';

class SelectLanguageScreen extends ConsumerStatefulWidget {
  final bool isFromSettings;
  const SelectLanguageScreen({
    required this.isFromSettings,
  });

  @override
  ConsumerState<SelectLanguageScreen> createState() =>
      _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends ConsumerState<SelectLanguageScreen> {
  String languageCode = 'en';
  @override
  void initState() {
    getLanguageCode();
    super.initState();
  }

  Future<void> getLanguageCode() async {
    languageCode = await ref.read(localStorageProvider).getLanguageStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromSettings
          ? AppBar(
              title: Text('Select Language'),
              centerTitle: true,
            )
          : AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isFromSettings
              ? SizedBox()
              : SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Add Your Hotel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Manage Easily',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 100),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choosing your prefferd language',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    height: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: 10),
                  RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'English',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: 'en',
                    groupValue: languageCode,
                    onChanged: (value) {
                      setState(() {
                        languageCode = value!;
                      });
                      context.setLocale(Locale(value!));
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Bangla',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: 'bn',
                    groupValue: languageCode,
                    onChanged: (value) {
                      setState(() {
                        languageCode = value!;
                      });
                      print(value);
                      context.setLocale(Locale(value!));
                    },
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomButton(
                      width: double.infinity,
                      onPressed: () {
                        ref
                            .read(localStorageProvider)
                            .saveLanguage(languageCode: languageCode);
                        widget.isFromSettings
                            ? Navigator.pop(context)
                            : Navigator.pushNamed(context, Routes.signUp);
                      },
                      buttonText: widget.isFromSettings ? 'Submit' : 'Next',
                      radius: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Text(
                  //   tr(LocaleKeys.welcome_to_flutter),
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
