import 'failures.dart';

class ErrorMapper {
  static String mapFailureToMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'تعذر الاتصال بالإنترنت حالياً، حاول مجددًا';
    }

    if (failure is ServerFailure) {
      return failure.message.isNotEmpty ? failure.message : 'حدث خطأ من الخادم';
    }

    return 'حدث خطأ غير متوقع';
  }
}
