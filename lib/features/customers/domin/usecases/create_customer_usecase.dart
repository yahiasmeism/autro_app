import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';
import '../repositories/customers_repository.dart';

@lazySingleton
class CreateCustomerUsecase extends UseCase<CustomerEntity, CreateCustomerUsecaseParams> {
  final CustomersRepository customersRepository;

  CreateCustomerUsecase({required this.customersRepository});
  @override
  Future<Either<Failure, CustomerEntity>> call(CreateCustomerUsecaseParams params) async {
    return await customersRepository.createCustomer(params);
  }
}

class CreateCustomerUsecaseParams extends Equatable {
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

  const CreateCustomerUsecaseParams({
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
  });

  @override
  List<Object?> get props => [
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
      ];
}
