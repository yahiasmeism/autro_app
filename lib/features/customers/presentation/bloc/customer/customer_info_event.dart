part of 'customer_info_bloc.dart';

sealed class CustomerInfoEvent extends Equatable {
  const CustomerInfoEvent();

  @override
  List<Object?> get props => [];
}

class InitialCustomerInfoEvent extends CustomerInfoEvent {
  final CustomerEntity? customer;
  final FormType formType;
  const InitialCustomerInfoEvent({this.customer, required this.formType});

  @override
  List<Object?> get props => [customer];
}

final class UpdateCustomerEvent extends CustomerInfoEvent {
  final CustomerEntity customer;
  const UpdateCustomerEvent({required this.customer});

  @override
  List<Object> get props => [customer];
}

class CreateCustomerEvent extends CustomerInfoEvent {
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

  const CreateCustomerEvent(
      {required this.name,
      required this.country,
      required this.city,
      required this.website,
      required this.businessDetails,
      required this.email,
      required this.phone,
      required this.altPhone,
      required this.primaryContactType,
      required this.notes});

  @override
  List<Object> get props => [];

  CreateCustomerUsecaseParams toParams() => CreateCustomerUsecaseParams(
        name: name,
        country: country,
        city: city,
        website: website,
        businessDetails: businessDetails,
        email: email,
        phone: phone,
        altPhone: altPhone,
        primaryContactType: primaryContactType,
        notes: notes,
      );
}
