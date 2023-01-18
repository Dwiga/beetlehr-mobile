part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccess extends ProfileState {
  final ProfileEntity data;

  ProfileSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ProfileFailure extends ProfileState {
  final Failure failure;

  ProfileFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
