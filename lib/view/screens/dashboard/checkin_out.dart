import 'package:flutter/material.dart';

class CheckinOut extends StatelessWidget {
  const CheckinOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Checkin & Out'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/checkin'),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Center(
                            child: Image.asset('assets/icons/check_in.png'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () => print('checkout'),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Center(
                            child: Image.asset('assets/icons/check_out.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Check-in'),
                    Text('Check-out'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
