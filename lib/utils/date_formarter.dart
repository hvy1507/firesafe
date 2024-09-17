import 'package:easy_localization/easy_localization.dart';

String formatDatetime(String datetimeString) {
  // Chuyển đổi chuỗi datetime thành đối tượng DateTime
  DateTime datetime = DateTime.parse(datetimeString);

  // Định dạng ngày tháng năm
  String formattedDatetime = DateFormat('dd/MM/yyyy').format(datetime);

  return formattedDatetime;
}