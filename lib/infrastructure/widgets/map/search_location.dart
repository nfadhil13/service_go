part of 'map_picker.dart';

class _SearchLocation extends StatefulWidget {
  final void Function(String address) onAddressSelected;
  const _SearchLocation({
    super.key,
    required this.onAddressSelected,
  });

  @override
  State<_SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<_SearchLocation> {
  late final GoogleMapsPlaces _gmapPlaces;

  final _searchController = TextEditingController();

  List<String> _predictions = [];

  bool _isLoading = false;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _gmapPlaces = GoogleMapsPlaces(apiKey: SGGoogleApiConst.apiKey);
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _query(_searchController.text);
    });
  }

  void _query(String text) async {
    if (text.isEmpty && _predictions.isNotEmpty) {
      setState(() {
        _predictions = [];
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final result = await _gmapPlaces.autocomplete(text);
    _predictions = result.predictions
        .where((element) => element.description != null)
        .map((e) => e.description!)
        .toList();
    _isLoading = false;
    setState(() {});
  }

  void _onItemTap(String item) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _clear();
    widget.onAddressSelected(item);
  }

  void _clear() {
    setState(() {
      _searchController.clear();
      _predictions = _predictions;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isLoading || _predictions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SGHideWidget(
                    child: SearchBar(
                  controller: _searchController,
                )),
                1.h.verticalSpace,
                Expanded(
                    child: _isLoading
                        ? const SGCircularLoading()
                        : ListView.builder(
                            itemCount: _predictions.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => _onItemTap(_predictions[index]),
                                child: ListTile(
                                  leading: const Icon(Icons.location_on),
                                  title: Text(_predictions[index]),
                                ),
                              );
                            },
                          )),
              ],
            ),
          ),
        SearchBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          textStyle: MaterialStatePropertyAll(context.text.bodyMedium),
          hintText: "Search Location",
          controller: _searchController,
          trailing: [
            IconButton(onPressed: _clear, icon: const Icon(Icons.close))
          ],
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ],
    );
  }
}
