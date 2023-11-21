import 'package:thimar/core/logic/helper_methods.dart';
import 'model.dart';

class CategoriesStates{}

class CategoriesLoadingState extends CategoriesStates{}

class CategoriesSuccessState extends CategoriesStates{
  final List<CategoryModel> list ;

  CategoriesSuccessState({required this.list});
}
class CategoriesFailedState extends CategoriesStates{
  final String message;

  CategoriesFailedState({required this.message});

}
