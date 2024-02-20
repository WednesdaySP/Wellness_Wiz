import 'dart:convert';
import 'dart:io';

import 'package:wellness/widgets/disease_data.dart';

class Disease {
  final String name;
  final List<String> symptoms;
  final List<String> causes;
  final List<String> precautions;

  Disease({
    required this.name,
    required this.symptoms,
    required this.causes,
    required this.precautions,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symptoms': symptoms,
      'causes': causes,
      'precautions': precautions,
    };
  }
}

void main() async {
  // Sample disease data
  final List<Disease> diseases = [
    Disease(
      name: 'Fever',
      symptoms: ['High body temperature', 'Headache', 'Muscle aches', 'Sweating', 'Chills'],
      causes: ['Viral infections', 'Bacterial infections', 'Heat exhaustion', 'Dehydration'],
      precautions: ['Rest', 'Stay hydrated', 'Medication for fever and pain'],
    ),
    Disease(
      name: 'Headache',
      symptoms: ['Pain in head', 'Sensitivity to light or noise', 'Nausea', 'Fatigue'],
      causes: ['Tension', 'Migraine', 'Sinus pressure'],
      precautions: ['Rest in a quiet and dark room', 'Stay hydrated', 'Medication for pain relief'],
    ),
    // Add more diseases here
  ];

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    handleRequest(request);
  }
}

void handleRequest(HttpRequest request) {
  try {
    if (request.method == 'GET') {
      final response = request.response
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(diseases.map((disease) => disease.toJson()).toList()));
      response.close();
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request: ${request.method}.');
      request.response.close();
    }
  } catch (e) {
    print('Exception in handling request: $e');
  }
}
