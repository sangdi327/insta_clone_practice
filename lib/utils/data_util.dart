import 'package:uuid/uuid.dart';

class DataUtil {
  static String makeFilePath() {
    return '${const Uuid().v4()}.jpg';
    // 확장자 따로 구분해야함, 해당 코드는 프로젝트에 있음
  }
}
