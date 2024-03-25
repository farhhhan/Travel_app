part of 'filter_bloc.dart';

 class FilterEvent {}

class ApplySliderEevent extends FilterEvent {
  final double minPrice;
  final double maxPrice;


  ApplySliderEevent({
    required this.minPrice,
    required this.maxPrice,
  });
   List<Object> get props => [minPrice,maxPrice];
}
class ApplyCateEvent extends FilterEvent {
  final String? selectedCategory;
  ApplyCateEvent({
  this.selectedCategory,
  });
    @override
  List<Object?> get props => [selectedCategory];
}

class ApplyType extends FilterEvent {
  final String? selectedtype;
  ApplyType({
  this.selectedtype,
  });
    @override
  List<Object?> get props => [selectedtype];
}
