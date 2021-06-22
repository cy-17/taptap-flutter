// 请求配置
class HttpOptions {
  // 连接服务器超时时间，单位是毫秒
  static const int CONNECT_TIMEOUT = 30000;
  // 接收超时时间，单位是毫秒
  static const int RECEIVE_TIMEOUT = 30000;

  static const String BASE_URL = 'http://192.168.137.181:9000';
}