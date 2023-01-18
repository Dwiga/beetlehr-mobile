part of 'access_bloc.dart';

abstract class AccessState extends Equatable {}

class AccessInitial extends AccessState {
  @override
  List<Object> get props => [];
}

class AccessUseMockLocation extends AccessState {
  @override
  List<Object> get props => [];
}

class AccessUseRoot extends AccessState {
  @override
  List<Object> get props => [];
}
