part of 'url_setting_bloc.dart';

class UrlSettingState extends Equatable {
  final URLFormZ url;
  final FormzStatus status;
  final BaseUrlSchema schema;
  final Failure? failure;

  const UrlSettingState({
    this.url = const URLFormZ.pure(),
    this.status = FormzStatus.pure,
    this.schema = BaseUrlSchema.http,
    this.failure,
  });

  UrlSettingState copyWith({
    URLFormZ? url,
    FormzStatus? status,
    BaseUrlSchema? schema,
    Failure? failure,
  }) {
    return UrlSettingState(
      url: url ?? this.url,
      status: status ?? this.status,
      schema: schema ?? this.schema,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [url, status, schema, failure];
}
