import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/filter/bloc/filter_bloc.dart';

class BottomSheetWidget extends StatelessWidget {
  final String name;
  final Function restestFilter;

  const BottomSheetWidget({
    required this.name,
    required this.restestFilter,
  });

  @override
  Widget build(BuildContext context) {
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
                      IconButton(
                        onPressed: () {
                          restestFilter();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.restart_alt),
                      ),
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
              if (name == 'Search Package')
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
                          ].map((String cates) => Padding(
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
                              )).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
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
                                      selectedtype: selected ? types : null));
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
                      restestFilter();
                      Navigator.pop(context);
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
  }
}



