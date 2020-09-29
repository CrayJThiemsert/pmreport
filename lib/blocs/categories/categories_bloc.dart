import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:pmreport/blocs/categories/categories.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';


part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository _categoriesRepository;
  StreamSubscription _categoriesSubscription;

  CategoriesBloc({@required CategoriesRepository categoriesRepository})
      : assert(categoriesRepository != null),
        _categoriesRepository = categoriesRepository,
        super(CategoriesLoading());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if(event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    } else if(event is AddCategory) {
      yield* _mapAddCategoryToState(event);
    } else if(event is UpdateCategory) {
      yield* _mapUpdateCategoryToState(event);
    } else if(event is DeleteCategory) {
      yield* _mapDeleteCategoryToState(event);
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if(event is CategoriesUpdated) {
      yield* _mapCategoriesUpdateToState(event);
    }
  }

  Stream<CategoriesState> _mapLoadCategoriesToState() async* {
    _categoriesSubscription?.cancel();
    _categoriesSubscription = _categoriesRepository.categories().listen(
          (categories) => add(CategoriesUpdated(categories)),
    );
  }

  Stream<CategoriesState> _mapAddCategoryToState(AddCategory event) async* {
    _categoriesRepository.addNewCategory(event.category);
  }

  Stream<CategoriesState> _mapUpdateCategoryToState(UpdateCategory event) async* {
    _categoriesRepository.updateCategory(event.updatedCategory);
  }

  Stream<CategoriesState> _mapDeleteCategoryToState(DeleteCategory event) async* {
    _categoriesRepository.deleteCategory(event.category);
  }

  Stream<CategoriesState> _mapClearCompletedToState() async* {
    final currentState = state;
    if(currentState is CategoriesLoaded) {
      final List<Category> completedCategories =
          currentState.categories.toList();
      completedCategories.forEach((completedCategory) {
        _categoriesRepository.deleteCategory(completedCategory);
      });
    }
  }

  Stream<CategoriesState> _mapCategoriesUpdateToState(CategoriesUpdated event) async* {
    yield CategoriesLoaded(event.categories);
  }

  @override
  Future<Function> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
