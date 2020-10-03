import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';

class CategoriesMenu extends StatelessWidget {
  CategoriesMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if(state is CategoriesLoading) {
          return LoadingIndicator();
        } else if(state is CategoriesLoaded) {
          final categories = state.categories;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                child: Center(
                  child: Text('${category.name}'),
                ),
              );
            },
          );
        }
      },
    );
  }
}
