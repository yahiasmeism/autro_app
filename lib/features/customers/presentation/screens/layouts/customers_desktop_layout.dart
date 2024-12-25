import 'package:autro_app/core/utils/nav_util.dart';
import 'package:flutter/material.dart';

import '../create_customer_screen.dart';

class CustomersDesktopLayout extends StatelessWidget {
  const CustomersDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Customers Desktop Layout'),
          ElevatedButton(
            onPressed: () {
              NavUtil.push(context, const CreateCustomerScreen());
            },
            child: const Text('Create Customer'),
          )
        ],
      ),
    );
  }
}
