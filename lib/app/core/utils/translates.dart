import 'package:get/get.dart';

class Translates extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcome': 'Welcome to myapp',
        },
        'vi_VI': {
          'welcome': 'Chào mừng đến với ứng dụng',
        }
      };
}
