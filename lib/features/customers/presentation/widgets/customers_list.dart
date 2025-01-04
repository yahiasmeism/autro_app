import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:flutter/material.dart';

import 'customer_list_tile.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key, required this.customers});
  final List<CustomerEntity> customers;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return CustomerListTile(customerEntity: customers[index]);
      },
    );
  }
}
