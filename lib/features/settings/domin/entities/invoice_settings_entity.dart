import 'package:equatable/equatable.dart';

class InvoiceSettingsEntity extends Equatable {
  final String modificationOnBl;
  final String shippingInstructions;
  final String specialConditions;
  final String exempt;
  final String typeOfTransport;
  final String loadingPictures;
  final String loadingDate;

  const InvoiceSettingsEntity(
      {required this.modificationOnBl,
      required this.shippingInstructions,
      required this.specialConditions,
      required this.exempt,
      required this.typeOfTransport,
      required this.loadingPictures,
      required this.loadingDate});

  @override
  List<Object?> get props => [
        modificationOnBl,
        shippingInstructions,
        specialConditions,
        exempt,
        typeOfTransport,
        loadingPictures,
        loadingDate,
      ];

  InvoiceSettingsEntity copyWith({
    String? modificationOnBl,
    String? shippingInstructions,
    String? specialConditions,
    String? exempt,
    String? typeOfTransport,
    String? loadingPictures,
    String? loadingDate,
  }) {
    return InvoiceSettingsEntity(
      modificationOnBl: modificationOnBl ?? this.modificationOnBl,
      shippingInstructions: shippingInstructions ?? this.shippingInstructions,
      specialConditions: specialConditions ?? this.specialConditions,
      exempt: exempt ?? this.exempt,
      typeOfTransport: typeOfTransport ?? this.typeOfTransport,
      loadingPictures: loadingPictures ?? this.loadingPictures,
      loadingDate: loadingDate ?? this.loadingDate,
    );
  }
}

