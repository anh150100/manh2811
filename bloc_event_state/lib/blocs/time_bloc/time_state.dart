import 'package:equatable/equatable.dart';

class TimeState extends Equatable{
  final int timeDuration;

  TimeState(this.timeDuration);
  @override
  // TODO: implement props
  List<Object> get props => [timeDuration];

}

class InitialState extends TimeState {
  final int timeDuration;
  InitialState(this.timeDuration) : super(timeDuration);
}

class RunningState extends TimeState {
  final int timeDuration;
  RunningState(this.timeDuration) : super(timeDuration);

}

class PauseState extends TimeState {
  final int timeDuration;

  PauseState(this.timeDuration) : super(timeDuration);

}

class CompletedState extends TimeState {
  CompletedState() : super(0);

}