import "encoder.dart";

abstract class Serializable {
  bool serialize(Encoder encoder);
  dynamic toJson();
}

abstract class FromJson<T> {
  T fromJson(dynamic json);
}

/*
List<T> toList<T extends FromJson<T>>(dynamic json) {
  List<T> fields = List();
  if(json != null) {
    final ts = json as List<dynamic>;
    for(final d in ts) {
      final f = T.fromJson(d);
      fields.add(f);
    }
  }
  return fields;
}
*/


List<String> strsToList(dynamic json) {
  List<String> fields = List();
  if(json != null) {
    final ts = json as List<dynamic>;
    for(final d in ts) {
      fields.add(d);
    }
  }
  return fields;
}

dynamic fromList<T extends Serializable>(List<T> objs) {
  List<dynamic> result = List();
  for(var id in objs) {
    result.add(id.toJson());
  }

  return result;
}

class SerializationException implements Exception {
  final String message;

  SerializationException([String this.message]);

  @override
  String toString() => "SerializationException: $message";

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != SerializationException) return false;
    return message == other.message;
  }
}