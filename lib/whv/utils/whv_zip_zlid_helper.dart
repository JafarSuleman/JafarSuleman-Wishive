import 'dart:io';
import 'dart:convert';
import 'package:convert/convert.dart';

String zipHtmlCode(String htmlCode) {
  String data = "";

  // Store the read data from the file to the variable data
  data = htmlCode;

  // Encode the data
  List<int> encodedData = utf8.encode(data);

  // Compress the encoded data with zlib
  List<int> compressedData = zlib.encode(encodedData);

  // Convert the binary compressed data to Hex
  String hexStr = hex.encode(compressedData);

  return hexStr;
}
