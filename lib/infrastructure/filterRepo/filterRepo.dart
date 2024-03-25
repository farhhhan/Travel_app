 import 'package:travel_app/domain/packageModel/packageModel.dart';


class FilterRepo{
  List<PackageModel> applyFilters(double minPrice, double maxPrice,
      String _selectedType, String _selectCate,List<PackageModel> packagelist) {
    print(minPrice);
    print(maxPrice);
    print(_selectedType);
    print(_selectCate);
    List<PackageModel> filteredList = packagelist.where((package) {
      double packagePrice = double.parse(package.packagePayment!);
      return packagePrice >= minPrice && packagePrice <= maxPrice;
    }).toList();

    if (_selectedType != null && _selectedType != 'All') {
      filteredList = filteredList
          .where((package) => package.packageType == _selectedType)
          .toList();
    }

    if (_selectCate != null && _selectCate != 'All') {
      filteredList = filteredList
          .where((package) => package.packageCategory == _selectCate)
          .toList();
    }

    return filteredList;
  }}