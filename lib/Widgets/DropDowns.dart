import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchableDropdown extends StatefulWidget {
  final String label;
  final int selectedValue;
  final List<Map<String, dynamic>> items;
  final Function(int) onChanged;

  const SearchableDropdown({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  bool _isDropdownOpen = false;
  String _searchQuery = '';
  late TextEditingController _searchController;
  late FocusNode _focusNode;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isDropdownOpen) {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    if (_isDropdownOpen) {
      _overlayEntry.remove();
    }
    super.dispose();
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff7C3AED), width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 20),
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.manrope(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                          _overlayEntry.markNeedsBuild();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildFilteredItems(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry.remove();
    setState(() {
      _isDropdownOpen = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  Widget _buildFilteredItems() {
    final filteredItems = widget.items.where((item) {
      final name = item['name'].toString().toLowerCase();
      final id = item['id'].toString();
      return name.contains(_searchQuery) || id.contains(_searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        final isSelected = item['id'] == widget.selectedValue;

        return InkWell(
          onTap: () {
            widget.onChanged(item['id']);
            _hideOverlay();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: isSelected ? Color(0xffEDE9FE) : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item['name']} (ID: ${item['id']})",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check, color: Color(0xff7C3AED), size: 18),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Find the currently selected item
    final selectedItem = widget.items.firstWhere(
      (item) => item['id'] == widget.selectedValue,
      orElse: () => {'id': widget.selectedValue, 'name': 'Unknown'},
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: InkWell(
          onTap: () {
            if (_isDropdownOpen) {
              _hideOverlay();
            } else {
              _showOverlay();
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff7C3AED), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              labelStyle: GoogleFonts.manrope(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              suffixIcon: Icon(
                _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
            child: Text(
              "${selectedItem['name']} (ID: ${selectedItem['id']})",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchableFamilyDropdown extends StatefulWidget {
  final String label;
  final int selectedValue;
  final List<Map<String, dynamic>> items;
  final Function(int) onChanged;

  const SearchableFamilyDropdown({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchableFamilyDropdown> createState() =>
      _SearchableFamilyDropdownState();
}

class _SearchableFamilyDropdownState extends State<SearchableFamilyDropdown> {
  bool _isDropdownOpen = false;
  String _searchQuery = '';
  late TextEditingController _searchController;
  late FocusNode _focusNode;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isDropdownOpen) {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    if (_isDropdownOpen) {
      _overlayEntry.remove();
    }
    super.dispose();
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff7C3AED), width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 20),
                        hintText: 'Search Family Head...',
                        hintStyle: GoogleFonts.manrope(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                          _overlayEntry.markNeedsBuild();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildFilteredItems(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry.remove();
    setState(() {
      _isDropdownOpen = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  Widget _buildFilteredItems() {
    final filteredItems = widget.items.where((item) {
      final familyHead = item['family_head'].toString().toLowerCase();
      final familyId = item['family_id'].toString();
      return familyHead.contains(_searchQuery) ||
          familyId.contains(_searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        final isSelected = item['family_id'] == widget.selectedValue;

        return InkWell(
          onTap: () {
            widget.onChanged(item['family_id']);
            _hideOverlay();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: isSelected ? Color(0xffEDE9FE) : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item['family_head']} (ID: ${item['family_id']})",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check, color: Color(0xff7C3AED), size: 18),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Find the currently selected item
    final selectedItem = widget.items.firstWhere(
      (item) => item['family_id'] == widget.selectedValue,
      orElse: () =>
          {'family_id': widget.selectedValue, 'family_head': 'Unknown'},
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: InkWell(
          onTap: () {
            if (_isDropdownOpen) {
              _hideOverlay();
            } else {
              _showOverlay();
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff7C3AED), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              labelStyle: GoogleFonts.manrope(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              suffixIcon: Icon(
                _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
            child: Text(
              "${selectedItem['family_head']} (ID: ${selectedItem['family_id']})",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}