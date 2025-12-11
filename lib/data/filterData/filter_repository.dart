import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_application/models/PropFilterModel.dart';
import 'package:rental_application/models/PropertyModel.dart';







class FilterNotifier extends StateNotifier<PropertyFilter>{
  FilterNotifier() : super(PropertyFilter());

  void setBhk(int? bhk){
    state = state.copyWith(bhk:bhk);
  }
  void setPriceRange(int? minPrice , int? maxPrice){
    state = state.copyWith(minPrice: minPrice, maxPrice:  maxPrice);

  }
  void setFurnished(bool? isFurnished){
    state = state.copyWith(isFurnished: isFurnished);

  }
  void setPropertyType(String? propertyType){
    state =  state.copyWith(propertyType: propertyType);
  }

  void resetFilters() {
    state = PropertyFilter();
  }
}