import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/delete_icon_button.dart';
import 'package:autro_app/core/widgets/edit_icon_button.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/presentation/screens/customer_proforma_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/nav_util.dart';
import '../bloc/customers_proformas_list/customers_proformas_list_bloc.dart';

class CustomerProformaListTile extends StatelessWidget {
  const CustomerProformaListTile({super.key, required this.proformaEntity});
  final CustomerProformaEntity proformaEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        NavUtil.push(context, ProformaFormScreen(formType: FormType.edit, proformaId: proformaEntity.id));
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
              text: proformaEntity.proformaNumber,
              flex: 4,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.formattedDate,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.customer.name,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.formattedTotalPrice,
            ),
            const SizedBox(width: 16),
            _buildCell(
              flex: 4,
              text: proformaEntity.goodsDescriptions.firstOrNull?.description ?? '-',
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditIconButton(
                    onPressed: () {
                      NavUtil.push(context, ProformaFormScreen(formType: FormType.edit, proformaId: proformaEntity.id));
                    },
                  ),
                  const SizedBox(width: 8),
                  DeleteIconButton(
                    onPressed: () {
                      context
                          .read<CustomersProformasListBloc>()
                          .add(DeleteProformaEvent(proformaId: proformaEntity.id, context: context));
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
