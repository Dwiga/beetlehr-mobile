library core;

export 'src/cache/cache.dart';
export 'src/exceptions/exceptions.dart';
export 'src/failures/failures.dart';
export 'src/global_config.dart';
export 'src/helpers/helpers.dart';
export 'src/model/models.dart';
export 'src/module/base_module.dart';
export 'src/network/network.dart';
export 'src/usecases/usecase.dart';
export 'src/utils/utils.dart';

/// Base module from [core]
///
/// Feature this module:
/// - Networking
///   1. Custom Headers
///   2. Basic Config Networking
///   3. Interceptors
///
/// - Exceptions
///   1. Server Exception (Abstracts/Interface)
///   2. Cache Exception (Abstracts/Interface)
///
/// - Failures
///   1. Server Failure
///   2. Cache Failure
///
/// - Base model [MetaData]
/// - Generic class [Usecase]
/// - Observing Bloc
