import 'package:autro_app/core/extensions/string_extension.dart';

import '../../domin/entities/invoice_settings_entity.dart';

class InvoiceSettingsModel extends InvoiceSettingsEntity {
  const InvoiceSettingsModel({
    required super.modificationOnBl,
    required super.shippingInstructions,
    required super.specialConditions,
    required super.exempt,
    required super.typeOfTransport,
    required super.loadingPictures,
    required super.loadingDate,
  });

  factory InvoiceSettingsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceSettingsModel(
      modificationOnBl: (json['modification_on_bl'] as String?).orEmpty,
      shippingInstructions: (json['shipping_instructions'] as String?).orEmpty,
      specialConditions: (json['special_conditions'] as String?).orEmpty,
      exempt: (json['exempt'] as String?).orEmpty,
      typeOfTransport: (json['type_of_transport'] as String?).orEmpty,
      loadingPictures: (json['loading_pictures'] as String?).orEmpty,
      loadingDate: (json['loading_date'] as String?).orEmpty,
    );
  }

  factory InvoiceSettingsModel.fromEntity(InvoiceSettingsEntity entity) {
    return InvoiceSettingsModel(
      modificationOnBl: entity.modificationOnBl,
      shippingInstructions: entity.shippingInstructions,
      specialConditions: entity.specialConditions,
      exempt: entity.exempt,
      typeOfTransport: entity.typeOfTransport,
      loadingPictures: entity.loadingPictures,
      loadingDate: entity.loadingDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'modification_on_bl': modificationOnBl,
        'shipping_instructions': shippingInstructions,
        'special_conditions': specialConditions,
        'exempt': exempt,
        'type_of_transport': typeOfTransport,
        'loading_pictures': loadingPictures,
        'loading_date': loadingDate,
      };
}
