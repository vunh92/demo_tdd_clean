import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/bloc/bloc.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/app_loading.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/upcoming_controls.dart';
import 'package:demo_tdd_clean/features/upcoming/presentation/widgets/upcoming_display.dart';
import 'package:demo_tdd_clean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
            _upcomingControls()
          ],
        ),
      ),
    );
  }

  Widget _upcomingControls() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text('Get Id'),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            onPressed: dispatchConcrete,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
            child: Text('Get Upcoming'),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            onPressed: dispatchUpcoming,
          ),
        ),
      ],
    );
  }

  void dispatchConcrete() {
    BlocProvider.of<UpcomingBloc>(context)
        .add(UpcomingIdLoadDataEvent('10402'));
  }

  void dispatchUpcoming() {
    // _upcomingBloc.add(UpcomingLoadDataEvent());
    BlocProvider.of<UpcomingBloc>(context).add(UpcomingLoadDataEvent());
  }
}
