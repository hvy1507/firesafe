import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FSImage extends StatelessWidget {
  factory FSImage.asset({
    Key? key,
    required String imageResource,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Color? color,
  }) {
    return FSImage._(
      key: key,
      imageResource: imageResource,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
    );
  }

  factory FSImage.network({
    Key? key,
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Widget Function(BuildContext context)? placeholder,
    Widget Function(BuildContext context, Widget widget, ImageChunkEvent? event)? loadingBuilder,
    Color? color,
  }) {
    return FSImage._(
      key: key,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholder: placeholder,
      loadingBuilder: loadingBuilder,
      color: color,
    );
  }

  factory FSImage.file({
    Key? key,
    required File file,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Widget Function(BuildContext context)? placeholder,
    Widget Function(BuildContext context, Widget widget, ImageChunkEvent? event)? loadingBuilder,
    Color? color,
  }) {
    return FSImage._(
      key: key,
      file: file,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholder: placeholder,
      loadingBuilder: loadingBuilder,
      color: color,
    );
  }

  const FSImage._({
    super.key,
    this.imageResource,
    this.imageUrl,
    this.file,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholder,
    this.loadingBuilder,
    this.color,
  });

  final File? file;
  final String? imageResource;
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Widget Function(BuildContext context)? placeholder;
  final Widget Function(BuildContext context, Widget widget, ImageChunkEvent? event)? loadingBuilder;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      if (file!.path.contains(RegExp(r'.*\.svg'))) {
        return SvgPicture.file(
          file!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          placeholderBuilder: placeholder,
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else {
        return Image.file(
          file!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          color: color,
          colorBlendMode: color == null ? null : BlendMode.srcIn,
        );
      }
    } else if (imageResource != null) {
      if (imageResource!.contains(RegExp(r'.*\.svg'))) {
        return SvgPicture.asset(
          imageResource!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          placeholderBuilder: placeholder,
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else {
        return Image.asset(
          imageResource!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          color: color,
          colorBlendMode: color == null ? null : BlendMode.srcIn,
        );
      }
    } else {
      if (imageUrl!.contains(RegExp(r'.*\.svg'))) {
        return SvgPicture.network(
          imageUrl!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          placeholderBuilder: placeholder,
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      } else {
        return CachedNetworkImage(
          width: width,
          height: height,
          fit: fit,
          placeholder: placeholder == null ? null : (context, _) {
            return placeholder!(context);
          },
          alignment: alignment,
          color: color,
          colorBlendMode: color == null ? null : BlendMode.srcIn, imageUrl:imageUrl!,
        );
      }
    }
  }
}
