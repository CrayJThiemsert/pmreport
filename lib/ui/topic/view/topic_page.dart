import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmreport/blocs/authentication/authentication.dart';
import 'package:pmreport/blocs/categories/categories.dart';
import 'package:pmreport/blocs/items/items_bloc.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/blocs/topics/topics_bloc.dart';
import 'package:pmreport/ui/part/widgets/part_menu.dart';
import 'package:pmreport/ui/topic/widgets/topic_menu.dart';
import 'package:preventive_maintenance_repository/preventive_maintenance_repository.dart';

class TopicPage extends StatelessWidget {
  String categoryUid;
  String partUid;
  String topicUid;
  Topic topic;

  TopicPage({this.categoryUid, this.partUid, this.topicUid, this.topic});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TopicPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TopicsBloc>(
            create: (context) {
              print('************ call load topics ***********');
              return TopicsBloc(
                topicsRepository: FirebaseTopicsRepository(),
              )..add(LoadTopics(categoryUid, partUid));
            },
          ),
          BlocProvider<PartsBloc>(
            create: (context) {
              print('************ call load parts ***********');
              return PartsBloc(
                partsRepository: FirebasePartsRepository(),
              )..add(LoadParts(categoryUid));
            },
          ),
          BlocProvider<ItemsBloc>(
            create: (context) {
              print('************ call load items ***********');
              return ItemsBloc(
                itemsRepository: FirebaseItemsRepository(),
              )..add(LoadItems(categoryUid, partUid, topicUid, topic));
                // ..add(LoadTemplateItems(categoryUid, partUid, topicUid, topic));
            },
          ),
        ],
        child: BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            if(state is TopicsLoaded) {
              final topics = state.topics;
              print('${topics.length}');
              String topicName = getTopicNameByUid(topics);

              return buildPage(context, topicName);
            } else if(state is TopicsLoading) {
              return CircularProgressIndicator();
            }

          },
        ),
      ),
    );

  }

  String getTopicNameByUid(List<Topic> topics) {
    String result = '';
    topics.forEach((element) {
      if(partUid == element.uid) {
        result = element.name;
      }
    });
    return result;
  }

  Topic getTopicByUid(List<Topic> topics) {
    Topic result;
    topics.forEach((element) {
      if(partUid == element.uid) {
        result = element;
      }
    });
    return result;
  }

  Scaffold buildPage(BuildContext context, String topicName) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${topicName} - [Topic]',
          style: TextStyle(
            fontSize: 14,

          ),),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),

      // stable version ===================
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopicsBloc>(
              create: (context) {
                print('************ call load topics ***********');
                return TopicsBloc(
                  topicsRepository: FirebaseTopicsRepository(),
                )..add(LoadTopics(categoryUid, partUid));
              },
            ),
            BlocProvider<PartsBloc>(
              create: (context) {
                print('************ call load parts ***********');
                return PartsBloc(
                  partsRepository: FirebasePartsRepository(),
                )..add(LoadParts(categoryUid));
              },
            ),
            BlocProvider<CategoriesBloc>(
              create: (context) {
                print('************ call load categories ***********');
                return CategoriesBloc(
                  categoriesRepository: FirebaseCategoriesRepository(),
                )..add(LoadCategories());
              },

            ),
            BlocProvider<ItemsBloc>(
              create: (context) {
                print('************ call load items ***********');
                return ItemsBloc(
                  itemsRepository: FirebaseItemsRepository(),
                )..add(LoadItems(categoryUid, partUid, topicUid, topic));
                // ..add(LoadTemplateItems(categoryUid, partUid, topicUid, topic));
              },
            ),
          ],

          child: TopicMenu(categoryUid: categoryUid, partUid: partUid, topicUid: topicUid,),
        ),
      ),


      // body: Align(
      //   alignment: const Alignment(0, -1 / 3),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       Avatar(photo: user.photoURL),
      //       const SizedBox(height: 4.0),
      //       Text(user.email, style: textTheme.headline6),
      //       const SizedBox(height: 4.0),
      //       Text(user.displayName ?? '', style: textTheme.headline5),
      //     ],
      //   ),
      // ),
      // ),
    );
  }
}
