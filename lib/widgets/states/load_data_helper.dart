part of 'data_state.dart';

mixin LoadDataHelper<TWidget extends StatefulWidget, TData> on DataState<TWidget> {
  TData loadedData;
  bool _isLoading = false;

  bool get hasLoadedData => loadedData != null;
  bool get isDataLoading => _isLoading;
  bool get isDataLoaded => hasLoadedData || hasError;
  String get defaultLoadingError => 'Oops, error occured while loading';

  Future<TData> get dataLoader;

  void onDataLoaded(TData data) async {}

  void onLoadError() {}

  Future<void> loadData() async {
    if (_isLoading) return;
    if (isDataLoaded) return;

    setState(() {
      _isLoading = true;
      clearPreloadedData();
    });

    try {
      loadedData = await dataLoader;
      onDataLoaded(loadedData);
      setState(() {
        _isLoading = false;
      });
    } on String catch (exception) {
      _errorText = exception;
      onLoadError();
    } catch (exception) {
      _errorText = defaultLoadingError;
      onLoadError();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void clearPreloadedData() {
    loadedData = null;
    _errorText = null;
  }

  void reloadData() => setState(clearPreloadedData);
}
