import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkUtil {
  static void openLink(BuildContext context, String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (await canLaunchUrlString(url)) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!context.mounted) return;
      DialogUtil.showErrorSnackBar(context, 'Could not launch $url');
    }
  }
}
