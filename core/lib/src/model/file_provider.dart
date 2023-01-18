enum FileFrom { network, device }

class FileProvider {
  final String path;
  final FileFrom from;

  FileProvider(this.path, this.from);

  String get name => path.split('/').last;
}
