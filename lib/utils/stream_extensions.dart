import 'dart:async';

class StreamExtensions {
  static Stream<List<T>> combine<T>(List<Stream<T>> streams) {
    final controller = StreamController<List<T>>();
    final values = List<T?>.filled(streams.length, null);

    for (var i = 0; i < streams.length; i++) {
      streams[i].listen((value) {
        values[i] = value;
        if (values.every((element) => element != null)) {
          controller.add(values.map((e) => e!).toList());
        }
      });
    }

    return controller.stream;
  }
}
