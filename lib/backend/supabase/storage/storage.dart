import '/flutter_flow/upload_data.dart';
import '../supabase.dart';

Future<List<String>> uploadSupabaseStorageFiles({
  required String bucketName,
  required List<SelectedFile> selectedFiles,
}) =>
    Future.wait(
      selectedFiles.map(
        (media) => uploadSupabaseStorageFile(
          bucketName: bucketName,
          selectedFile: media,
        ),
      ),
    );

Future<String> uploadSupabaseStorageFile({
  required String bucketName,
  required SelectedFile selectedFile,
}) async {
  final storageBucket = SupaFlow.client.storage.from(bucketName);
  final ext = selectedFile.storagePath.split('.').last.toLowerCase();
  final contentType = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'gif': 'image/gif',
    'webp': 'image/webp',
    'heic': 'image/heic',
    'heif': 'image/heif',
  }[ext] ?? 'image/jpeg';
  await storageBucket.uploadBinary(
    selectedFile.storagePath,
    selectedFile.bytes,
    fileOptions: FileOptions(contentType: contentType),
    retryAttempts: 3,
  );
  return storageBucket.getPublicUrl(selectedFile.storagePath);
}

Future deleteSupabaseFileFromPublicUrl(String publicUrl) async {
  final storagePath = SupaFlow.client.storage.pathFromPublicUrl(publicUrl);
  if (storagePath == null) {
    return;
  }

  final bucketName = storagePath.split('/').first;
  final filePath = storagePath.split('/').skip(1).join('/');
  await SupaFlow.client.storage.from(bucketName).remove([filePath]);
}

extension _SupabaseBucketExtensions on SupabaseStorageClient {
  String? pathFromPublicUrl(String publicUrl) {
    final publicUrlPrefix = '$url/object/public/';
    final urlParts = publicUrl.split(publicUrlPrefix);
    if (urlParts.length != 2) {
      return null;
    }
    final fullStoragePath = urlParts.last;
    final storagePathParts = fullStoragePath.split('/');
    if (storagePathParts.length <= 1) {
      return null;
    }
    return fullStoragePath;
  }
}
