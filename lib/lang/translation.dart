import 'package:get/get.dart';
import 'en_lang.dart';
import 'ar_lang.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
