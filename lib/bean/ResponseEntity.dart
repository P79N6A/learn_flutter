import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class ResponseEntity {

  int status;
  int command;
  String url;
  String content;
}