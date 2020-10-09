import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pmreport/blocs/blocs.dart';
import 'package:pmreport/blocs/parts/parts.dart';
import 'package:pmreport/blocs/topics/topics_bloc.dart';
import 'package:pmreport/ui/home/widgets/loading_indicator.dart';
import 'package:pmreport/utils/sizes_helpers.dart';

class TopicsMenu extends StatelessWidget {
  String categoryUid;
  String partUid;
  TopicsMenu({Key key, this.categoryUid, this.partUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {

        if(state is TopicsLoading) {
          return LoadingIndicator();
        } else if(state is TopicsNotLoaded) {
          return Container(
            child: Text('Data not found'),
          );
        } else if(state is TopicsLoaded) {
          final topics = state.topics;
          return Container(
            height: displayHeight(context) * 0.22,
            width: displayWidth(context),
            // color: Colors.blueAccent,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Bounce(
                  duration: Duration(milliseconds: 100),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/${categoryUid}_h96.png',
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0,),
                        child: new Text(
                          "${topics[index].name}",
                          style: TextStyle(fontSize: 20.0, color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    print('${topics[index].name} pressed...');
                  },
                );
              },
              autoplay: false,
              itemCount: topics.length,
              pagination: new SwiperPagination(
                  margin: new EdgeInsets.all(0.0),
                  builder: new SwiperCustomPagination(builder:
                      (BuildContext context, SwiperPluginConfig config) {
                        return DotSwiperPaginationBuilder(
                                  color: Colors.black12,
                                  activeColor: Colors.brown,
                                  size: 5.0,
                                  activeSize: 10.0
                          ).build(context, config);
                  }
                  )
              ),
              control: new SwiperControl(color: Colors.redAccent),
            ),
          );
        }
      },
    );
  }
}
