import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String name;
  final String country;
  final String city;
  final String website;
  final String businessDetails;
  final String email;
  final String phone;
  final String altPhone;
  final String primaryContact;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomerEntity(
      {required this.id,
      required this.name,
      required this.country,
      required this.city,
      required this.website,
      required this.businessDetails,
      required this.email,
      required this.phone,
      required this.altPhone,
      required this.primaryContact,
      required this.notes,
      required this.createdAt,
      required this.updatedAt});
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
        primaryContact,
        notes,
        createdAt,
        updatedAt,
      ];
}
