import 'dart:convert'; // برای تبدیل JSON
import 'package:http/http.dart' as http;

void sendData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final body = json.encode({
    'title': 'foo',
    'body': 'bar',
    'userId': 1,
  });

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body,
  );

  if (response.statusCode == 201) {
    final data = json.decode(response.body);
    print('Data sent successfully: $data');
  } else {
    print('Failed to send data. Status code: ${response.statusCode}');
  }
}

void main() {
  sendData();
}
