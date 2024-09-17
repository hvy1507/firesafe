// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['originId'] as String,
      json['brand'] as String,
      json['model'] as String,
      json['shortDescription'] as String,
      json['available'] as bool,
      (json['certificates'] as List<dynamic>)
          .map((e) => Certificate.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['warranty'] as int,
      json['packaging'] as String,
      json['shippingTime'] as int,
      json['hasSample'] as String,
      json['productionRate'] as String,
      json['accessories'] as String?,
      json['postSupport'] as String?,
      json['faq'] as String?,
      json['shape'] as String?,
      json['color'] as String?,
      json['material'] as String?,
      json['weight'] as int?,
      json['volume'] as int?,
      json['structure'] as String?,
      json['fireResistant'] as String?,
      json['waterResistant'] as String?,
      json['applications'] as String?,
      json['additionalSpecification'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      json['productId'] as String,
      json['name'] as String,
      json['thumbnail'] as String,
      json['rating'] as int,
      json['price'] as int?,
      json['priceMax'] as int?,
      json['priceMin'] as int?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'originId': instance.originId,
      'brand': instance.brand,
      'model': instance.model,
      'shortDescription': instance.shortDescription,
      'available': instance.available,
      'certificates': instance.certificates.map((e) => e.toJson()).toList(),
      'warranty': instance.warranty,
      'packaging': instance.packaging,
      'shippingTime': instance.shippingTime,
      'hasSample': instance.hasSample,
      'productionRate': instance.productionRate,
      'accessories': instance.accessories,
      'postSupport': instance.postSupport,
      'faq': instance.faq,
      'shape': instance.shape,
      'color': instance.color,
      'material': instance.material,
      'weight': instance.weight,
      'volume': instance.volume,
      'structure': instance.structure,
      'fireResistant': instance.fireResistant,
      'waterResistant': instance.waterResistant,
      'applications': instance.applications,
      'additionalSpecification': instance.additionalSpecification,
      'images': instance.images,
      'categories': instance.categories,
      'productId': instance.productId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'rating': instance.rating,
      'price': instance.price,
      'priceMax': instance.priceMax,
      'priceMin': instance.priceMin,
    };

Certificate _$CertificateFromJson(Map<String, dynamic> json) => Certificate(
      json['name'] as String,
      json['image'] as String,
    );

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
    };
