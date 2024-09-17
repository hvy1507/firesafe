import 'dart:ui';

part 'color_resource.dart';
part 'image_resource.dart';
part 'string_resource.dart';

class R {
  R._();

  static final string = _StringResource();
  static final image = _ImageResource();
  static final color = _ColorResource();
}
