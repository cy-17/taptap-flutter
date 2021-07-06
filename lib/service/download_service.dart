import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  /// 下载apk
  static Future<File> downloadApk(String datasource, String storagePath,
      ProgressCallback progressCallback) async {
    /// 创建文件
    File file = new File('$storagePath');

    /// 判断文件是否存在，不存在则创建文件
    if (!file.existsSync()) {
      file.createSync();
    }
    Response<List<int>> response = await Dio().get<List<int>>(
        "https://fga1.market.xiaomi.com/download/AppStore/0eeeb4617d19bb21319d0fdf61f9f4544a1428e91/com.mantec.fsn.apk",
        onReceiveProgress: progressCallback,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));
    file.writeAsBytes(response.data!);
    return file;
  }

  /// 安装apk
  static Future<Null> installApk(
      String url, String gameName, ProgressCallback progressCallback) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.requestInstallPackages, Permission.storage].request();

    if (statuses[Permission.storage] == PermissionStatus.denied) return;
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir!.path + '/$gameName.apk';

    File file = new File(storagePath);

    /// 判断文件是否存在，不存在则创建文件
    if (!file.existsSync()) {
      file = await downloadApk(url, storagePath, progressCallback);
    }
    final _result = await OpenFile.open(file.path);
    print(_result.message);
  }

  static Future<Null> openApk(String gameName) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.requestInstallPackages, Permission.storage].request();

    if (statuses[Permission.storage] == PermissionStatus.denied) return;
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir!.path + '/$gameName.apk';

    File file = new File(storagePath);
    final _result = await OpenFile.open(file.path);
    print(_result.message);
  }

  static Future<bool> apkExist(String gameName) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.requestInstallPackages, Permission.storage].request();

    if (statuses[Permission.storage] == PermissionStatus.denied) return false;
    Directory? storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir!.path + '/$gameName.apk';

    File file = new File(storagePath);

    /// 判断文件是否存在，不存在则创建文件
    if (!file.existsSync()) {
      return false;
    } else
      return true;
  }
}
