import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firesafe_vnex/app/main/add_product/add_product.cubit.dart';
import 'package:firesafe_vnex/app/main/add_product/add_product.state.dart';
import 'package:firesafe_vnex/components/commons/product_categories.dart';
import 'package:firesafe_vnex/components/widgets/clickable.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/models/country/country.model.dart';
import 'package:firesafe_vnex/models/enum_values/load_state.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/scope.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/resources/resources.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AddProductCubit get cubit => getCubit();

  bool isFixedPrice = true;

  Future<List<File>?> pickFiles() async {
    try {
      final FilePickerResult? results = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (results != null) {
        return results.paths.map((result) => File(result!)).toList();
      }
      return null;
    } on Exception {
      return null;
    }
  }

  Future<File?> pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      return result?.let((r) {
        return r.paths.firstOrNull?.let((path) {
          return File(path);
        });
      });
    } on Exception {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<AddProductCubit, AddProductState>(
        listenWhen: (_, state) => state.newProductId != null,
        listener: (context, state) {
          Fluttertoast.showToast(msg: 'Thêm sản phẩm mới thành công!');
          context.pushReplacementNamed(
            routes.detail,
            pathParameters: {'id': state.newProductId!},
          );
        },
        builder: (context, state) {
          if (state.loadState == LoadState.loading) {
            return const FSProgressIndicator(
              size: 60,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              buildProductCategory(state),
              buildProductName(),
              buildOrigin(state),
              buildBrand(),
              buildModel(),
              buildShortDescription(),
              buildPrice(),
              buildAvailable(state),
              buildWarranty(),
              buildPackaging(),
              buildShippingTime(),
              buildHasSample(),
              buildProductionRate(),
              buildThumbnail(state),
              buildImages(state),
              buildCertificate(state),
              buildAccessories(),
              buildPostSupport(),
              buildFAQ(),
              buildShape(),
              buildColor(),
              buildMaterial(),
              buildWeight(),
              buildVolume(),
              buildStructure(),
              buildAdditionalSpecification(state),
              buildFireResistant(),
              buildWaterResistant(),
              buildApplications(),
              buildDone(),
              // buildAdditionalSpecification(),
            ].addBetween(
              const SizedBox(
                height: 16,
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        R.string.addProductScreen.postProduct.tr(),
        style: TextStyle(fontSize: 20, color: R.color.mainColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildProductCategory(AddProductState state) {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.categories.tr(),
      child: Card(
        child: ExpansionTile(
          title: Text(
            R.string.addProductScreen.categories.tr(),
            style: context.bodyM.copyWith(fontWeight: FontWeight.w500),
          ),
          children: Category.values.map((c) {
            return CheckboxListTile(
              side: BorderSide(
                width: 2,
                color: R.color.mainColor,
              ),
              dense: true,
              title: Text(c.toText().tr()),
              controlAffinity: ListTileControlAffinity.leading,
              value: state.categories.contains(c),
              onChanged: (bool? value) {
                if (value == true) {
                  cubit.addCategory(c);
                } else {
                  cubit.removeCategory(c);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildOrigin(AddProductState state) {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.origin.tr(),
      child: DropdownMenu<CountryModel>(
        expandedInsets: EdgeInsets.zero,
        hintText: R.string.addProductScreen.origin.tr(),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme,
        enableSearch: false,
        dropdownMenuEntries: state.countries.map<DropdownMenuEntry<CountryModel>>((value) {
          return DropdownMenuEntry<CountryModel>(
            value: value,
            label: value.name,
          );
        }).toList(),
        onSelected: (model) {
          if (model != null) {
            cubit.setOriginId(model);
          }
        },
      ),
    );
  }

  Widget buildImages(AddProductState state) {
    return buildField(
      title: R.string.addProductScreen.images.tr(),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...(state.images ?? []).map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.file(
                      e,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton.filledTonal(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        cubit.removeImage(e);
                      },
                      icon: FSImage.asset(
                        imageResource: R.image.vector.close,
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Clickable(
              onTap: () async {
                pickFiles().then((value) {
                  value?.let((it) => cubit.addImages(it));
                });
              },
              child: Container(
                color: R.color.textFieldColor,
                alignment: Alignment.center,
                child: FSImage.asset(
                  imageResource: R.image.vector.galleryOutlined,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Stack(
  //                 clipBehavior: Clip.none,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(16),
  //                     child: AspectRatio(
  //                       aspectRatio: 1,
  //                       child: Image.file(
  //                         e,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     top: -20,
  //                     right: -20,
  //                     child: IconButton.filledTonal(
  //                       style: ButtonStyle(
  //                           shape: MaterialStateProperty.all(
  //                             const CircleBorder(),
  //                           ),
  //                           visualDensity: VisualDensity.compact,
  //                           backgroundColor: MaterialStateProperty.all(R.color.mainColor)),
  //                       onPressed: () {
  //                         // setState(
  //                         //       () {
  //                         //     _selectedFiles.removeAt(_selectedFiles.indexOf(e));
  //                         //   },
  //                         // );
  //                       },
  //                       icon: const Icon(
  //                         Icons.close,
  //                         color: Colors.white,
  //                         size: 20,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),

  Widget buildPrice() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.pricing.tr(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  onTap: () {
                    setState(() {
                      isFixedPrice = true;
                    });
                  },
                  title: Text(R.string.addProductScreen.fixedPrice.tr()),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: isFixedPrice,
                    onChanged: (bool? value) {
                      setState(() {
                        isFixedPrice = value == true;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  onTap: () {
                    setState(() {
                      isFixedPrice = false;
                    });
                  },
                  title: Text(R.string.addProductScreen.rangedPrice.tr()),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: isFixedPrice,
                    onChanged: (bool? value) {
                      setState(() {
                        isFixedPrice = value == true;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isFixedPrice
                ? FSTextField(
                    hint: R.string.addProductScreen.fixedPrice.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      cubit.setPrice(
                        price: int.tryParse(value),
                      );
                    },
                  )
                : Row(
                    children: [
                      Expanded(
                        child: FSTextField(
                          label: R.string.addProductScreen.minPrice.tr(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            cubit.setPrice(
                              minPrice: int.tryParse(value),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FSTextField(
                          label: R.string.addProductScreen.maxPrice.tr(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            cubit.setPrice(
                              maxPrice: int.tryParse(value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildThumbnail(AddProductState state) {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.thumbnail.tr(),
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Clickable(
            onTap: () async {
              pickFile().then((value) {
                value?.let((it) => cubit.setThumbnail(it));
              });
            },
            child: state.thumbnail != null
                ? FSImage.file(
                    file: state.thumbnail!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Container(
                    color: R.color.textFieldColor,
                    alignment: Alignment.center,
                    child: FSImage.asset(
                      imageResource: R.image.vector.galleryOutlined,
                      width: 48,
                      height: 48,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildProductName() {
    return buildField(
      title: R.string.addProductScreen.name.tr(),
      isRequired: true,
      child: FSTextField(
        hint: R.string.addProductScreen.name.tr(),
        onChanged: (value) {
          cubit.setName(value);
        },
        maxLength: 50,
      ),
    );
  }

  Widget buildModel() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.model.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.model.tr(),
        onChanged: (value) {
          cubit.setModel(value);
        },
        maxLength: 100,
      ),
    );
  }

  Widget buildBrand() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.brand.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.brand.tr(),
        onChanged: (value) {
          cubit.setBrand(value);
        },
        maxLength: 100,
      ),
    );
  }

  Widget buildShippingTime() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.shippingTime.tr(),
      child: FSTextField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hint: R.string.addProductScreen.shippingTime.tr(),
        onChanged: (value) {
          cubit.setShippingTime(int.tryParse(value) ?? -1);
        },
      ),
    );
  }

  Widget buildPackaging() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.packaging.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.packaging.tr(),
        onChanged: (value) {
          cubit.setPackaging(value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildHasSample() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.sample.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.sample.tr(),
        onChanged: (value) {
          cubit.setHasSample(value);
        },
        maxLength: 500,
      ),
    );
  }

  // List<Widget> buildIsNew() {
  //   return [
  //     Text(
  //       R.string.addProductScreen.productStatus.tr().toUpperCase(),
  //       style: const TextStyle(
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     Column(
  //       children: <Widget>[
  //         ListTile(
  //           title: Text(R.string.addProductScreen.neww.tr()),
  //           leading: Radio<IsNew>(
  //             value: IsNew.brandNew,
  //             groupValue: isNew,
  //             onChanged: (IsNew? value) {
  //               setState(
  //                     () {
  //                   isNew = value;
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         ListTile(
  //           title: Text(R.string.addProductScreen.old.tr()),
  //           leading: Radio<IsNew>(
  //             value: IsNew.old,
  //             groupValue: isNew,
  //             onChanged: (IsNew? value) {
  //               setState(
  //                     () {
  //                   isNew = value;
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     )
  //   ];
  // }

  Widget buildWarranty() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.warranty.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.warranty.tr(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          cubit.setWarranty(int.tryParse(value) ?? -1);
        },
      ),
    );
  }

  Widget buildFAQ() {
    return buildField(
      title: R.string.addProductScreen.faq.tr(),
      child: SizedBox(
        height: 200,
        child: FSTextField(
          hint: R.string.addProductScreen.faq.tr(),
          expands: true,
          maxLines: null,
          onChanged: (value) {
            cubit.setFaq(value.isEmpty ? null : value);
          },
          maxLength: 10000,
        ),
      ),
    );
  }

  Widget buildShortDescription() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.shortDescription.tr(),
      child: SizedBox(
        height: 200,
        child: FSTextField(
          hint: R.string.addProductScreen.shortDescription.tr(),
          expands: true,
          maxLines: null,
          onChanged: (value) {
            cubit.setShortDescription(value);
          },
          maxLength: 10000,
        ),
      ),
    );
  }

  Widget buildAvailable(AddProductState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          R.string.addProductScreen.available.tr(),
          style: context.bodyM.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Checkbox(
          value: state.available,
          onChanged: (value) {
            cubit.setAvailable(value: value == true);
          },
        ),
      ],
    );
  }

  Widget buildProductionRate() {
    return buildField(
      isRequired: true,
      title: R.string.addProductScreen.productionRate.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.productionRate.tr(),
        onChanged: (value) {
          cubit.setProductionRate(value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildAccessories() {
    return buildField(
      title: R.string.addProductScreen.accessories.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.accessories.tr(),
        onChanged: (value) {
          cubit.setAccessories(value.isEmpty ? null : value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildPostSupport() {
    return buildField(
      title: R.string.addProductScreen.postSupport.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.postSupport.tr(),
        onChanged: (value) {
          cubit.setPostSupport(value.isEmpty ? null : value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildShape() {
    return buildField(
      title: R.string.addProductScreen.shape.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.shape.tr(),
        onChanged: (value) {
          cubit.setShape(value.isEmpty ? null : value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildColor() {
    return buildField(
      title: R.string.addProductScreen.color.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.color.tr(),
        onChanged: (value) {
          cubit.setColor(value.isEmpty ? null : value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildMaterial() {
    return buildField(
      title: R.string.addProductScreen.material.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.material.tr(),
        onChanged: (value) {
          cubit.setMaterial(value.isEmpty ? null : value);
        },
        maxLength: 500,
      ),
    );
  }

  Widget buildWeight() {
    return buildField(
      title: R.string.addProductScreen.weight.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.weight.tr(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          cubit.setWeight(int.tryParse(value));
        },
      ),
    );
  }

  Widget buildVolume() {
    return buildField(
      title: R.string.addProductScreen.volume.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.volume.tr(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          cubit.setVolume(int.tryParse(value));
        },
      ),
    );
  }

  Widget buildStructure() {
    return buildField(
      title: R.string.addProductScreen.structure.tr(),
      child: FSTextField(
        hint: R.string.addProductScreen.structure.tr(),
        onChanged: (value) {
          cubit.setStructure(value.isEmpty ? null : value);
        },
        maxLength: 1000,
      ),
    );
  }

  Widget buildFireResistant() {
    return buildField(
      title: R.string.addProductScreen.fireResistant.tr(),
      child: SizedBox(
        height: 200,
        child: FSTextField(
          hint: R.string.addProductScreen.fireResistant.tr(),
          expands: true,
          maxLines: null,
          onChanged: (value) {
            cubit.setFireResistant(value.isEmpty ? null : value);
          },
          maxLength: 1000,
        ),
      ),
    );
  }

  Widget buildWaterResistant() {
    return buildField(
      title: R.string.addProductScreen.waterResistant.tr(),
      child: SizedBox(
        height: 200,
        child: FSTextField(
          hint: R.string.addProductScreen.waterResistant.tr(),
          expands: true,
          maxLines: null,
          onChanged: (value) {
            cubit.setWaterResistant(value.isEmpty ? null : value);
          },
          maxLength: 1000,
        ),
      ),
    );
  }

  Widget buildApplications() {
    return buildField(
      title: R.string.addProductScreen.applications.tr(),
      child: SizedBox(
        height: 200,
        child: FSTextField(
          hint: R.string.addProductScreen.applications.tr(),
          expands: true,
          maxLines: null,
          onChanged: (value) {
            cubit.setApplication(value.isEmpty ? null : value);
          },
          maxLength: 1000,
        ),
      ),
    );
  }

  Widget buildField({
    required String title,
    required Widget child,
    bool isRequired = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.bodyM.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isRequired)
              Text(
                R.string.addProductScreen.required.tr(),
                style: context.bodyS.copyWith(
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }

  File? cert;
  final certC = TextEditingController();
  Widget buildCertificate(AddProductState state) {
    return buildField(
      title: R.string.addProductScreen.certificate.tr(),
      isRequired: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...state.certificates.map((e) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 96,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FSImage.file(
                        file: e.$2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e.$1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.removeCertificate(e);
                  },
                  icon: const Icon(Icons.remove),
                ),
              ].addBetween(const SizedBox(width: 8)),
            );
          }),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 96,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Clickable(
                    onTap: () async {
                      pickFiles().then((value) {
                        if (value != null && value.firstOrNull != null) {
                          setState(() {
                            cert = value.first;
                          });
                        }
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: cert == null
                          ? Container(
                              color: R.color.textFieldColor,
                              alignment: Alignment.center,
                              child: FSImage.asset(
                                imageResource: R.image.vector.galleryOutlined,
                                width: 48,
                                height: 48,
                              ),
                            )
                          : FSImage.file(
                              file: cert!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FSTextField(
                  controller: certC,
                  hint: R.string.addProductScreen.certificate.tr(),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              IconButton(
                onPressed: (cert == null || certC.text.isEmpty)
                    ? null
                    : () {
                        cubit.addCertificate(cert!, certC.text);
                        cert = null;
                        certC.clear();
                      },
                icon: const Icon(Icons.add),
              ),
            ].addBetween(const SizedBox(width: 8)),
          ),
        ].addBetween(const SizedBox(height: 4)),
      ),
    );
  }

  Widget buildDone() {
    return FilledButton(
      onPressed: () {
        cubit.addProduct();
      },
      child: Text(
        R.string.addProductScreen.postProduct,
      ).tr(),
    );
  }

  final keyC = TextEditingController();
  final valC = TextEditingController();
  Widget buildAdditionalSpecification(AddProductState state) {
    return buildField(
      title: R.string.addProductScreen.additionalSpecification.tr(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...?state.additionalSpecification?.entries.map((entry) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: context.bodyM.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(entry.value),
                ),
                IconButton(
                  onPressed: () {
                    cubit.removeAdditionalField(entry.key);
                  },
                  icon: const Icon(Icons.remove),
                ),
              ].addBetween(const SizedBox(
                width: 8,
              )),
            );
          }),
          Row(
            children: <Widget>[
              Expanded(
                child: FSTextField(
                  controller: keyC,
                  keyboardType: TextInputType.text,
                  hint: R.string.addProductScreen.property.tr(),
                  onChanged: (_) => setState(() {}),
                  maxLength: 50,
                ),
              ),
              Expanded(
                child: FSTextField(
                  controller: valC,
                  keyboardType: TextInputType.text,
                  hint: R.string.addProductScreen.value.tr(),
                  onChanged: (_) => setState(() {}),
                  maxLength: 200,
                ),
              ),
              IconButton(
                onPressed: (keyC.text.isEmpty && valC.text.isEmpty)
                    ? null
                    : () {
                        cubit.addAdditionalField(keyC.text, valC.text);
                        keyC.clear();
                        valC.clear();
                      },
                icon: const Icon(Icons.add),
              ),
            ].addBetween(const SizedBox(
              width: 8,
            )),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    keyC.dispose();
    valC.dispose();
    certC.dispose();
  }
}
