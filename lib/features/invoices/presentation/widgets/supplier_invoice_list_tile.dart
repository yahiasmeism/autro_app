import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/utils/nav_util.dart';
import '../bloc/suppliers_invoices_list/suppliers_invoices_list_bloc.dart';
import '../screens/supplier_invoices_form_screen.dart';

class SupplierInvoiceListTile extends StatelessWidget {
  const SupplierInvoiceListTile({super.key, required this.invoiceEntity});
  final SupplierInvoiceEntity invoiceEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, SupplierInvoiceFormScreen(formType: FormType.edit, supplierInvoiceId: invoiceEntity.id));
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
              text: invoiceEntity.number,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.supplier.name,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: "€${invoiceEntity.totalAmount.toStringAsFixed(2)}",
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.date.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.material,
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
                          context, SupplierInvoiceFormScreen(formType: FormType.edit, supplierInvoiceId: invoiceEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<SuppliersInvoicesListBloc>().add(
                            DeleteInvoiceEvent(
                              invoiceId: invoiceEntity.id,
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
