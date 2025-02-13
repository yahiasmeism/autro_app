import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class SendStatus extends StatelessWidget {
  const SendStatus({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: status.toLowerCase() == 'sent' ? Colors.green.shade50 : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              status.capitalized,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: status.toLowerCase() == 'sent' ? Colors.green : Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}
