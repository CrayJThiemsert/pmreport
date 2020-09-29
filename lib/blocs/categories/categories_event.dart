part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoriesEvent {}

class AddCategory extends CategoriesEvent {
  final Category category;
  
  const AddCategory(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'AddCategory { category: $category }';
}

class UpdateCategory extends CategoriesEvent {
  final Category updatedCategory;

  const UpdateCategory(this.updatedCategory);

  @override
  List<Object> get props => [updatedCategory];

  @override
  String toString() => 'UpdateCategory { updatedCategory: $updatedCategory }';
}

class DeleteCategory extends CategoriesEvent {
  final Category category;

  const DeleteCategory(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'DeleteCategory { ategory: $category }';
}

class ClearCompleted extends CategoriesEvent {}

class CategoriesUpdated extends CategoriesEvent {
  final List<Category> categories;

  const CategoriesUpdated(this.categories);

  @override
  List<Object> get props => [categories];
}
