import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

class RemoteProductService {
  var client = http.Client();
  var remote = '$baseUrl/api/products';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('$remote/?populate=images,tags'),
    );

    return response;
  }
}
