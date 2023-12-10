class MyGlobalData {
  static final MyGlobalData _singleton = MyGlobalData._internal();

  factory MyGlobalData() {
    return _singleton;
  }

  MyGlobalData._internal();

  String token = "";
}


// class Test{

//   final String token;

//   Test({
//     required this.token
//   });
// }