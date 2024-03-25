part of 'filter_bloc.dart';

class FilterState {
   double minPrice=1500;
   double maxPrice=250000;
   String selectedCategory;
   String? selectedType;

  FilterState({
    this.minPrice=1500,
    this.maxPrice=250000,
    this.selectedCategory='All',
    this.selectedType='All',
  });
  FilterState copyWith({
    double? minPrice,
    double? maxPrice,
    String? selectedCategory,
    String? selectedType,
  }) {
    return FilterState(
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedType: selectedType ?? this.selectedType
    );
  }
  List<Object> get props => [minPrice,maxPrice,selectedCategory,selectedType!];
}
