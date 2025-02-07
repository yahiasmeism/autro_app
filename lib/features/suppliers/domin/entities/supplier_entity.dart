import 'package:autro_app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class SupplierEntity extends Equatable {
  final int id;
  final String name;
  final String country;
  final String city;
  final String website;
  final String businessDetails;
  final String email;
  final String phone;
  final String altPhone;
  final PrimaryContectType primaryContactType;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int dealsCount;
  final double netProfit;

  const SupplierEntity({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.website,
    required this.businessDetails,
    required this.email,
    required this.phone,
    required this.altPhone,
    required this.primaryContactType,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.dealsCount,
    required this.netProfit,
  });

  String get primaryContact {
    switch (primaryContactType) {
      case PrimaryContectType.email:
        return email;
      case PrimaryContectType.phone:
        return phone;
      default:
        return '-';
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        city,
        website,
        businessDetails,
        email,
        phone,
        altPhone,
        primaryContactType,
        notes,
        createdAt,
        updatedAt,
        dealsCount,
        netProfit,
      ];

  SupplierEntity copyWith({
    int? id,
    String? name,
    String? country,
    String? city,
    String? website,
    String? businessDetails,
    String? email,
    String? phone,
    String? altPhone,
    PrimaryContectType? primaryContactType,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? dealsCount,
    double? netProfit,
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      website: website ?? this.website,
      businessDetails: businessDetails ?? this.businessDetails,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      altPhone: altPhone ?? this.altPhone,
      primaryContactType: primaryContactType ?? this.primaryContactType,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dealsCount: dealsCount ?? this.dealsCount,
      netProfit: netProfit ?? this.netProfit,
    );
  }
}
