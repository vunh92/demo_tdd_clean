import 'package:demo_tdd_clean/features/upcoming/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingControls extends StatefulWidget {
  const UpcomingControls({Key key}) : super(key: key);

  @override
  _UpcomingControlsState createState() => _UpcomingControlsState();
}

class _UpcomingControlsState extends State<UpcomingControls> {
  @override
  Widget build(BuildContext context) {
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
