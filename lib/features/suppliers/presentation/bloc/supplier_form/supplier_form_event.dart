part of 'supplier_form_bloc.dart';

sealed class SupplierFormEvent extends Equatable {
  const SupplierFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialSupplierFormEvent extends SupplierFormEvent {
  final SupplierEntity? supplier;
  final FormType formType;
  const InitialSupplierFormEvent({this.supplier, required this.formType});

  @override
  List<Object?> get props => [supplier];
}

final class UpdateSupplierFormEvent extends SupplierFormEvent {
  final SupplierEntity supplier;
  const UpdateSupplierFormEvent({required this.supplier});

  @override
  List<Object> get props => [supplier];
}

class CreateSupplierFormEvent extends SupplierFormEvent {
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

  const CreateSupplierFormEvent(
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

  CreateSupplierUsecaseParams toParams() => CreateSupplierUsecaseParams(
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
