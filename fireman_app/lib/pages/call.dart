import 'package:url_launcher/url_launcher.dart';
class CallInFlutter {
  CallInFlutter._();

  static Future<void> callnumber(String contact) async {
    Uri dialnumber = Uri(scheme: 'tel', path: contact);

    if (await canLaunchUrl(dialnumber)) {
      await launchUrl(dialnumber);
    } else {
      throw 'Could not launch Dial log';
    }
  }
}
