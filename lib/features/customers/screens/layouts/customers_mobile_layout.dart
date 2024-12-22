import 'package:flutter/material.dart';

import '../../../../core/utils/nav_util.dart';
import '../create_customer_screen.dart';

class CustomersMobileLayout extends StatelessWidget {
  const CustomersMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Customers Mobile Layout'),
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
