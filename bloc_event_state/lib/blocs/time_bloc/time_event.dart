import 'package:equatable/equatable.dart';

class TimeEvent extends Equatable{
  const TimeEvent();
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class StartEvent extends TimeEvent {
  final int timeDuration;

  StartEvent(this.timeDuration);

}

class RunEvent extends TimeEvent {
  final int timeDuration;

  RunEvent(this.timeDuration);

}

class PauseEvent extends TimeEvent{}

class ResumeEvent extends TimeEvent{}

class ResetEvent extends TimeEvent{}