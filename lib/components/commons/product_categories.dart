import 'package:firesafe_vnex/components/resources/resources.dart';

enum Category {
  material,
  constructionMaterial,
  paint,
  pipeCable,
  electricSystem,
  door,
  householdAppliance,
  other;

  @override
  String toString() {
    switch (this) {
      case Category.material:
        return 'category_material';
      case Category.constructionMaterial:
        return 'category_construction_material';
      case Category.paint:
        return 'category_paint';
      case Category.pipeCable:
        return 'category_pipe_cable';
      case Category.electricSystem:
        return 'category_electric_system';
      case Category.door:
        return 'category_door';
      case Category.householdAppliance:
        return 'category_household_appliance';
      case Category.other:
        return 'category_other';
    }
  }

  String toText() {
    switch (this) {
      case Category.material:
        return R.string.categories.material;
      case Category.constructionMaterial:
        return R.string.categories.constructionMaterial;
      case Category.paint:
        return R.string.categories.paint;
      case Category.pipeCable:
        return R.string.categories.pipeCable;
      case Category.electricSystem:
        return R.string.categories.electricSystem;
      case Category.door:
        return R.string.categories.door;
      case Category.householdAppliance:
        return R.string.categories.householdAppliance;
      case Category.other:
        return R.string.categories.other;
    }
  }

  String get image {
    switch (this) {
      case Category.material:
        return R.image.drawable.categories.material;
      case Category.constructionMaterial:
        return R.image.drawable.categories.constructionMaterial;
      case Category.paint:
        return R.image.drawable.categories.paint;
      case Category.pipeCable:
        return R.image.drawable.categories.pipe;
      case Category.electricSystem:
        return R.image.drawable.categories.electricSystem;
      case Category.door:
        return R.image.drawable.categories.door;
      case Category.householdAppliance:
        return R.image.drawable.categories.householdAppliance;
      case Category.other:
        return R.image.drawable.categories.other;
    }
  }

  static Category parse(String input) {
    switch (input) {
      case 'category_material':
        return Category.material;
      case 'category_construction_material':
        return Category.constructionMaterial;
      case 'category_paint':
        return Category.paint;
      case 'category_pipe_cable':
        return Category.pipeCable;
      case 'category_electric_system':
        return Category.electricSystem;
      case 'category_door':
        return Category.door;
      case 'category_household_appliance':
        return Category.householdAppliance;
      default:
        return Category.other;
    }
  }
}
