// ignore_for_file: avoid_print

class ImageHelper {
  static String buildImage(String path) {
    String link = path.replaceAll("\\", "/");
    return link.toString();
  }
}
