import 'package:easy_localization/easy_localization.dart';

extension StringListExt<String> on List<String> {
  List<String> removeDuplicates() {
    var list = <String>[];
    this.forEach((value) {
      if (!list.contains(value)) {
        list.add(value);
      }
    });
    
    this.clear();
    this.addAll(list);
    return this;
  }
}

extension DateTimeFormat on DateTime {
  String get ddMMyyyy => DateFormat("dd/MM/yyyy").format(this);
}
