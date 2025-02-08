import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/nav_util.dart';
import '../bloc/suppliers_proformas_list/suppliers_proformas_list_bloc.dart';
import '../screens/supplier_proformas_form_screen.dart';

class SupplierProformaListTile extends StatelessWidget {
  const SupplierProformaListTile({super.key, required this.proformaEntity});
  final SupplierProformaEntity proformaEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, SupplierProformaFormScreen(formType: FormType.edit, supplierProformaId: proformaEntity.id));
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCell(
              text: proformaEntity.number,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.supplier.name,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: "€${proformaEntity.totalAmount.toStringAsFixed(2)}",
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.date.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.material,
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(
                          context, SupplierProformaFormScreen(formType: FormType.edit, supplierProformaId: proformaEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<SuppliersProformasListBloc>().add(
                            DeleteProformaEvent(
                              proformaId: proformaEntity.id,
                              context: context,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell({required String text, required int flex, TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(
        text.isEmpty ? '-' : text,
        style: style ??
            TextStyles.font16Regular.copyWith(
              color: AppColors.secondaryOpacity50,
            ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: true,
      ),
    );
  }
}
