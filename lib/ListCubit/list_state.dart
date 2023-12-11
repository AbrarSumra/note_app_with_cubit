class ListState {
  ListState({
    required this.mData,
    this.isLoading = false,
    this.isError = false,
    this.errorMsg = "",
  });

  List<Map<String, dynamic>> mData;
  bool isLoading;
  bool isError;
  String errorMsg;
}
