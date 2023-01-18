part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {}

class ChangeBottomNavEvent extends BottomNavEvent {
  final int index;

  ChangeBottomNavEvent({
    required this.index,
  });

  @override
  List<Object> get props => [index];

  @override
  bool get stringify => true;
}
