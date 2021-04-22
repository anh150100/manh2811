import 'package:bloc_event_state/blocs/time_bloc/time.dart';
import 'package:bloc_event_state/blocs/time_bloc/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider<TimeBloc>(
          create: (context) => TimeBloc(),
          child: BlocBuilder<TimeBloc, TimeState>(
          builder: (context, state)
          {
            final String minuteStr = ((state.timeDuration / 60) % 60).floor().toString().padLeft(2, '0');
            final String secondStr =
            (state.timeDuration % 60).floor().toString().padLeft(2, '0');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$minuteStr:$secondStr',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: 50
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: buttons(context, state),
                  )

                ],
              ),
            );
          }
      ),
    ),
    );
  }

  buttons(context, state)
  {
    final TimeBloc timeBloc = BlocProvider.of<TimeBloc>(context);

    if(state is InitialState)
    {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timeBloc.add(StartEvent(state.timeDuration)),
        ),

      ];
    }
    else if( state is RunningState){
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timeBloc.add(PauseEvent()),
        ),

        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timeBloc.add(ResetEvent()),
        ),
      ];
    }
    else if(state is PauseState)
    {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timeBloc.add(ResumeEvent()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timeBloc.add(ResetEvent()),
        ),
      ];
    }

    else if (state is CompletedState)
    {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timeBloc.add(ResetEvent()),
        ),
      ];
    }
    return [];
  }
}
