import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:bloc_event_state/blocs/time_bloc/time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeBloc extends Bloc<TimeEvent,TimeState>{

  static int _timeDuration = 60;
  TimeBloc() : super(InitialState(_timeDuration));
  StreamSubscription<int>  _timeSubscription; // ignore: unused_field
  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    // TODO: implement mapEventToState
    if(event is StartEvent){
      yield RunningState(event.timeDuration);

      _timeSubscription?.cancel();
      _timeSubscription = changeTime(event.timeDuration).listen((timeDuration) {
        return add(RunEvent(timeDuration));
      });
    }
    else if (event is RunEvent){
      yield event.timeDuration > 0 ? RunningState(event.timeDuration): CompletedState();
    }
    else if (event is PauseEvent){
      _timeSubscription?.pause();
      yield PauseState(state.timeDuration);

    }
    else if (event is ResumeEvent){
      _timeSubscription?.resume();
      yield RunningState(state.timeDuration);
    }
    else if (event is ResetEvent){
      _timeSubscription?.cancel();
      yield InitialState(_timeDuration);
    }
  }
    Stream<int> changeTime(int time) {
      return Stream.periodic(Duration(seconds: 1), (x) => time - x - 1)
          .take(time);
    }

}