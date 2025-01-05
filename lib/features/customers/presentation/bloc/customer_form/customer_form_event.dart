part of 'customer_form_bloc.dart';

sealed class CustomerFormEvent extends Equatable {
  const CustomerFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialCustomerFormEvent extends CustomerFormEvent {
  final CustomerEntity? customer;
  final FormType formType;
  const InitialCustomerFormEvent({this.customer, required this.formType});

  @override
  List<Object?> get props => [customer];
}

final class UpdateCustomerFormEvent extends CustomerFormEvent {
  final CustomerEntity customer;
  const UpdateCustomerFormEvent({required this.customer});

  @override
  List<Object> get props => [customer];
}

class CreateCustomerFormEvent extends CustomerFormEvent {
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

  const CreateCustomerFormEvent(
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
