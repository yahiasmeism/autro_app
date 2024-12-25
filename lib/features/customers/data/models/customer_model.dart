import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity implements BaseMapable {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.country,
    required super.city,
    required super.website,
    required super.businessDetails,
    required super.email,
    required super.phone,
    required super.altPhone,
    required super.primaryContact,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      country: entity.country,
      city: entity.city,
      website: entity.website,
      businessDetails: entity.businessDetails,
      email: entity.email,
      phone: entity.phone,
      altPhone: entity.altPhone,
      primaryContact: entity.primaryContact,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: (json['id'] as int?).toIntOrZero,
      name: (json['name'] as String?).orEmpty,
      country: (json['country'] as String?).orEmpty,
      city: (json['city'] as String?).orEmpty,
      website: (json['website'] as String?).orEmpty,
      businessDetails: (json['business_details'] as String?).orEmpty,
      email: (json['email'] as String?).orEmpty,
      phone: (json['phone'] as String?).orEmpty,
      altPhone: (json['alt_phone'] as String?).orEmpty,
      primaryContact: (json['primary_contact'] as String?).orEmpty,
      notes: (json['notes'] as String?).orEmpty,
      createdAt: DateTime.tryParse(json['created_at']).orDefault,
      updatedAt: DateTime.tryParse(json['updated_at']).orDefault,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "city": city,
        "website": website,
        "business_details": businessDetails,
        "email": email,
        "phone": phone,
        "alt_phone": altPhone,
        "primary_contact": primaryContact,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
