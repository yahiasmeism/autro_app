import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/dashboard/domin/entities/activity_entity.dart';
import 'package:autro_app/features/dashboard/domin/entities/dashboard_entity.dart';

import 'activity_model.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalRevenue,
    required super.totalExpenses,
    required super.netProfit,
    required super.totalDeals,
    required super.totalCustomers,
    required super.topCustomers,
    required super.lastActivities,
    required super.topProduct,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        totalRevenue: (json['total_revenue'] as num?).toDoubleOrZero,
        totalExpenses: (json['total_expenses'] as num?).toDoubleOrZero,
        netProfit: (json['net_profit'] as num?).toDoubleOrZero,
        totalDeals: (json['total_deals'] as num?).toIntOrZero,
        totalCustomers: (json['total_customers'] as num?).toIntOrZero,
        topProduct: (json['top_description'] as String?).orEmpty,
        topCustomers: List<CustomerEntity>.of(
          (json['top_customers'] as List).orEmpty.map(
                (e) => CustomerModel.fromJson((e as Map<String, dynamic>?).orEmpty),
              ),
        ),
        lastActivities: List<ActivityEntity>.of(
          (json['activities'] as List).orEmpty.map(
                (e) => ActivityModel.fromJson((e as Map<String, dynamic>?).orEmpty),
              ),
        ),
      );
}
