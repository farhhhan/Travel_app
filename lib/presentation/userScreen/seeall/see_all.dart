import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/application/bloc/filter/bloc/filter_bloc.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/infrastructure/filterRepo/filterRepo.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/package_card.dart';

class SeeAllScreen extends StatefulWidget {
  final List<PackageModel> packagelist;
  final String name;

  SeeAllScreen({required this.packagelist, required this.name, Key? key})
      : super(key: key);

  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late List<PackageModel> _filteredPackages;
  late TextEditingController _searchController;
  late StreamController<List<PackageModel>> _streamController;
  late Stream<List<PackageModel>> _filteredPackagesStream;
  @override
  void initState() {
    super.initState();
    _filteredPackages = widget.packagelist;
    _searchController = TextEditingController();
    _streamController = StreamController<List<PackageModel>>.broadcast();
    _filteredPackagesStream = _streamController.stream;
    _streamController.add(widget.packagelist);
    _searchController.addListener(() {
      _streamController.add(_filterPackages(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _streamController.close();
    super.dispose();
  }

  List<PackageModel> _filterPackages(String query) {
    if (query.isEmpty) {
      return widget.packagelist;
    } else {
      return widget.packagelist.where((package) {
        return package.packageName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text('Price Range'),
                      ),
                      Row(
                        children: [
                          IconButton.outlined(
                              onPressed: () {
                                restestFilter();

                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.restart_alt)),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${state.minPrice.toStringAsFixed(0)}'),
                        Text('${state.maxPrice.toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
                  RangeSlider(
                    values: RangeValues(state.minPrice, state.maxPrice),
                    min: 1500,
                    max: 250000,
                    divisions: 100,
                    onChanged: (RangeValues values) {
                      context.read<FilterBloc>().add(ApplySliderEevent(
                          minPrice: values.start, maxPrice: values.end));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.name == 'Search Package')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text('Sorted By types'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                'All',
                                'Best',
                                'Recommended',
                                'Popular'
                              ]
                                  .map((String cates) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ChoiceChip(
                                          label: Text(cates),
                                          selected:
                                              state.selectedCategory == cates,
                                          onSelected: (bool selected) {
                                            context.read<FilterBloc>().add(
                                                ApplyCateEvent(
                                                    selectedCategory: selected
                                                        ? cates
                                                        : null));
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  // Render Sorting by Type
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text('Sorted By Type'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: ['All', 'Primium', 'Normal', 'Lite']
                            .map((String types) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ChoiceChip(
                                    label: Text(types),
                                    selected: state.selectedType == types,
                                    onSelected: (bool selected) {
                                      context.read<FilterBloc>().add(ApplyType(
                                          selectedtype:
                                              selected ? types : null));
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _streamController.add(FilterRepo().applyFilters(
                              state.minPrice,
                              state.maxPrice,
                              state.selectedType!,
                              state.selectedCategory,
                              widget.packagelist));
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: Text('Apply Filters'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child:TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: "Search place",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 22,
                  color: Colors.black,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: _showFilterSheet,
                      child: Container(
                        width: 48.00,
                        height: 48.00,
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder<List<PackageModel>>(
                  stream: _filteredPackagesStream,
                  initialData: widget.packagelist,
                  builder: (context, snapshot) {
                    final filteredPackages = snapshot.data ?? [];
                    return StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      children: [
                        Center(
                          child: Text(
                            "Found ${filteredPackages.length} results",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        for (var i = 0; i < filteredPackages.length; i++)
                          InkWell(
                            onTap: () {
                              print(filteredPackages[i].imageUrlList);
                            },
                            child: PackageCard(
                              imageUrl: filteredPackages[i].imageUrlList![0],
                              packageModel: filteredPackages[i],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void restestFilter() {
    context.read<FilterBloc>().add(ApplyCateEvent(selectedCategory: 'All'));
    context.read<FilterBloc>().add(ApplyType(selectedtype: 'All'));
    context
        .read<FilterBloc>()
        .add(ApplySliderEevent(minPrice: 1500, maxPrice: 250000));
    _streamController.add(FilterRepo()
        .applyFilters(1500, 250000, 'All', 'All', widget.packagelist));
  }
}
