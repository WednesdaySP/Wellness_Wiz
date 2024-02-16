// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

// class DocumentScannerScreen extends StatefulWidget {
//   @override
//   _DocumentScannerScreenState createState() => _DocumentScannerScreenState();
// }

// class _DocumentScannerScreenState extends State<DocumentScannerScreen> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   String _extractedText = '';

//   Future<void> _getImageFromCamera() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _getImageFromGallery() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _generateTextFromImage() async {
//     if (_imageFile == null) return;

//     try {
//       final extractedText = await FlutterTesseractOcr.extractText(_imageFile!.path);
//       setState(() {
//         _extractedText = extractedText;
//       });
//     } catch (e) {
//       print('Error extracting text: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _imageFile == null
//                 ? Text('No image selected.')
//                 : Image.file(
//                     _imageFile!,
//                     height: 200.0,
//                   ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _getImageFromCamera,
//               child: Text('Take a Photo'),
//             ),
//             ElevatedButton(
//               onPressed: _getImageFromGallery,
//               child: Text('Pick from Gallery'),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _generateTextFromImage,
//               child: Text('Generate Text'),
//             ),
//             SizedBox(height: 20.0),
//             Text(_extractedText),
//           ],
//         ),
//       ),
//     );
//   }
// }
