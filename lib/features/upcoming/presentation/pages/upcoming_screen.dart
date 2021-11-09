import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/bloc/bloc.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/app_loading.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/upcoming_controls.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/upcoming_display.dart';
import 'package:demo_tdd_clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming'),
      ),
      body: BlocProvider(
        create: (context) => getIt<UpcomingBloc>(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.orange[100],
                child: BlocBuilder<UpcomingBloc, UpcomingState>(
                  builder: (context, state) {
                    if (state is EmptyState) {
                      return Center(child: Text('Upcoming List!'),);
                    }else if (state is LoadingState) {
                      return AppLoading();
                    }else if (state is LoadedState) {
                      return UpcomingDisplay(upcomingList: state.upcomingList);
                      // return _buildBody(state.upcoming);
                    }else if (state is ErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            UpcomingControls()
          ],
        ),
      ),
    );
  }

  Widget _buildBody(Upcoming upcoming) {
    return GestureDetector(
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          return Container(
            child: upcoming != null
                // ? _buildGridViewProduct(state.upcomingList)
                ? Container(child: Text('upcoming'),)
                : Container(child: Text('null')),
          );
          // return _buildGridViewProduct(state.upcomingList);
        },
      ),
    );
  }

  /*Widget _buildGridViewProduct(List<Upcoming> upcomingList) {
    return GridView.builder(
        primary: true,
        physics: ScrollPhysics(),
        itemCount: upcomingList.length,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 2/3
        ),
        itemBuilder: (context, index) {
          return _buildItemProduct(upcomingList[index], index);
        });
  }*/

  /*Widget _buildItemProduct(Upcoming upcoming, int index) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingDetailScreen(id: upcoming.id.toString(),),));
      },
      child: CachedNetworkImage(
        imageUrl: upcoming.posterArtUrl,
        imageBuilder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: url, fit: BoxFit.cover ),
            ),
            // width: 80,
            // height: 120,
          );
        },
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }*/
}
