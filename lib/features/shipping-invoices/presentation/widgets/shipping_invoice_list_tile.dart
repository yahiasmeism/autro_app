import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/shipping-invoices/presentation/screens/shipping_invoices_form_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/send_status.dart';
import '../../domin/entities/shipping_invoice_entity.dart';
import '../bloc/shipping_invoice_list/shipping_invoices_list_bloc.dart';

class ShippingInvoiceListTile extends StatelessWidget {
  const ShippingInvoiceListTile({super.key, required this.shippingInvoiceEntity});
  final ShippingInvoiceEntity shippingInvoiceEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, ShippingInvoiceFormScreen(formType: FormType.edit, id: shippingInvoiceEntity.id));
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
              text: shippingInvoiceEntity.shippingInvoiceNumber,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: shippingInvoiceEntity.shippingInvoiceNumber,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: shippingInvoiceEntity.shippingCompanyName,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: shippingInvoiceEntity.shippingDate.formattedDateMMMDDY,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: shippingInvoiceEntity.formmatedShippingCost,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: shippingInvoiceEntity.typeMaterialName.isEmpty ? "-" : shippingInvoiceEntity.typeMaterialName,
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: SendStatus(status: shippingInvoiceEntity.status),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(context, ShippingInvoiceFormScreen(formType: FormType.edit, id: shippingInvoiceEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context
                          .read<ShippingInvoicesListBloc>()
                          .add(DeleteShippingInvoiceEvent(shippingInvoiceId: shippingInvoiceEntity.id));
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
