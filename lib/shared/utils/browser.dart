import 'package:url_launcher/url_launcher.dart';

Future<bool> openBrowser(String link) async {
  if (link.isNotEmpty) {
    final Uri url = Uri.parse(link);
    try {
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}
