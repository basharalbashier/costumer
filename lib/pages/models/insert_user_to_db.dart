import '../../helpers/replace_numbers.dart';
import 'db.dart';

Future<bool> doTheInsert(Map userdate, String phone) async {
  var insert = await DBProvider.db.addMe({
    'id': userdate['super']['id'],
    'name': userdate['super']['name'],
    'phone': replaceArabicNumber(phone),
    'email': userdate['super']['email'],
    'account': userdate['super']['account'],
    'token': userdate['token']
  });

  if (insert) {
    return true;
  } else {
    return false;
  }
}
