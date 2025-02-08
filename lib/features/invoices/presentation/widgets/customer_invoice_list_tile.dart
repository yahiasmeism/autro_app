import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/presentation/screens/custoemr_invoice_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/customers_invoices_list/customers_invoices_list_bloc.dart';

class CustomerInvoiceListTile extends StatelessWidget {
  const CustomerInvoiceListTile({super.key, required this.invoiceEntity});
  final CustomerInvoiceEntity invoiceEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, CustomerInvoiceFormScreen(formType: FormType.edit, invoiceId: invoiceEntity.id));
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
              text: invoiceEntity.invoiceNumber,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.formattedDate,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.customer.name,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.formattedTotalPrice,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: invoiceEntity.goodsDescriptions.firstOrNull?.description ?? '-',
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(context, CustomerInvoiceFormScreen(formType: FormType.edit, invoiceId: invoiceEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context.read<CustomersInvoicesListBloc>().add(DeleteInvoiceEvent(
                            invoiceId: invoiceEntity.id,
                            context: context,
                          ));
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
        text,
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
