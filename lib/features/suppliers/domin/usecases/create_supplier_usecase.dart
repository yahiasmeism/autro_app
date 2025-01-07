import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/repositoreis/suppliers_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/interfaces/use_case.dart';

@lazySingleton
class CreateSupplierUsecase extends UseCase<SupplierEntity, CreateSupplierUsecaseParams> {
  final SuppliersRepository suplliersRepository;

  CreateSupplierUsecase({required this.suplliersRepository});

  @override
  Future<Either<Failure, SupplierEntity>> call(CreateSupplierUsecaseParams params) async {
    return await suplliersRepository.createSupplier(params);
  }
}

class CreateSupplierUsecaseParams extends Equatable {
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

  const CreateSupplierUsecaseParams({
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
