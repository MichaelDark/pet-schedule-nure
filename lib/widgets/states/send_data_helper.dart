part of 'data_state.dart';

mixin SendDataHelper<TWidget extends StatefulWidget, TData> on DataState<TWidget> {
  bool _isSending = false;

  bool get isDataSending => _isSending;
  String get defaultSendingError => 'Oops, error occured while sending';

  Future<void> dataSender(TData data);

  void onDataSent(TData data) {}

  void onSendError() {}

  Future<void> sendData(TData data) async {
    setState(() {
      _isSending = true;
    });
    try {
      await dataSender(data);
      onDataSent(data);
      setState(() {
        _isSending = false;
      });
    } on String catch (exception) {
      _errorText = exception;
      onSendError();
    } catch (exception) {
      _errorText = defaultSendingError;
      onSendError();
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }
}
