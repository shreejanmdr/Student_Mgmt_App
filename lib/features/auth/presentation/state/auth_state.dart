class AuthState {
  final bool isLoading;

  final String? error;

  final String? imageName;

 

  AuthState({required this.isLoading, this.error, this.imageName});

  factory AuthState.initial() => AuthState(
        isLoading: false,
        error: null,
        imageName: null,
        
      );

  AuthState copyWith({
    bool? isLoading,
    String? imageName,
    String? error,
    
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      
    );
  }
}
