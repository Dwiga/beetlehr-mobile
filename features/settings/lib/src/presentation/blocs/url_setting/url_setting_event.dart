part of 'url_setting_bloc.dart';

abstract class UrlSettingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeUrlSettingEvent extends UrlSettingEvent {
  final String url;
  final BaseUrlSchema schema;

  ChangeUrlSettingEvent(this.url, this.schema);

  @override
  List<Object?> get props => [url, schema];
}

class UrlSettingSubmittedEvent extends UrlSettingEvent {}
