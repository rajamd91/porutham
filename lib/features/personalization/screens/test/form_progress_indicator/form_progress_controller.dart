import 'package:get/get.dart';

class FormController extends GetxController {
  // Track completed pages
  var completedPages = <int>[].obs;

  // Calculate progress percentage
  double get progress => completedPages.length / 5;

  // Mark a page as completed
  void completePage(int pageIndex) {
    if (!completedPages.contains(pageIndex)) {
      completedPages.add(pageIndex);
    }
  }

  // Check if a page is completed
  bool isPageCompleted(int pageIndex) {
    return completedPages.contains(pageIndex);
  }
}
