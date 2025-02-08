import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/dashboard/domin/entities/activity_entity.dart';
import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final double totalRevenue;
  final double totalExpenses;
  final double netProfit;
  final int totalDeals;
  final int totalCustomers;
  final List<CustomerEntity> topCustomers;
  final List<ActivityEntity> lastActivities;
  final String topProduct;

  const DashboardEntity({
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
    required this.totalDeals,
    required this.totalCustomers,
    required this.topCustomers,
    required this.lastActivities,
    required this.topProduct,
  });
  @override
  List<Object?> get props => [
        totalRevenue,
        totalExpenses,
        netProfit,
        totalDeals,
        totalCustomers,
        topCustomers,
        lastActivities,
        topProduct,
      ];
}
