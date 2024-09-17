import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String Function(T) displayItemFunction;
  final void Function(T?) onChanged;
  final String hintText;

  const SearchableDropdown({
    Key? key,
    required this.items,
    required this.displayItemFunction,
    required this.onChanged,
    this.value,
    this.hintText = 'Select an item',
  }) : super(key: key);

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _textEditingController = TextEditingController();
  bool _isOpen = false;
  late OverlayEntry _overlayEntry;
  String? _searchText;
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.value;
    if (_selectedItem != null) {
      _textEditingController.text = widget.displayItemFunction(_selectedItem!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: Icon(Icons.arrow_drop_down),
        ),
        readOnly: true,
        onTap: () {
          setState(() {
            _isOpen = !_isOpen;
            if (_isOpen) {
              _overlayEntry = _createOverlayEntry();
              Overlay.of(context).insert(_overlayEntry);
            } else {
              _overlayEntry.remove();
            }
          });
        },
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                          _overlayEntry.markNeedsBuild();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: widget.items
                          .where((item) => _searchText == null ||
                          _searchText!.isEmpty ||
                          widget
                              .displayItemFunction(item)
                              .toLowerCase()
                              .contains(_searchText!.toLowerCase()))
                          .map((item) => ListTile(
                        title: Text(widget.displayItemFunction(item)),
                        onTap: () {
                          setState(() {
                            _selectedItem = item;
                            _textEditingController.text =
                                widget.displayItemFunction(item);
                            _isOpen = false;
                            _overlayEntry.remove();
                          });
                          widget.onChanged(item);
                        },
                      ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}