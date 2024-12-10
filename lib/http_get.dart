import 'dart:convert'; // برای تبدیل JSON
import 'package:http/http.dart' as http;

void fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Data received: $data');
  } else {
    print('Failed to load data. Status code: ${response.statusCode}');
  }
}

void main() {
  fetchData();
}
