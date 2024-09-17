extension ScopeExtensionNullable<T extends Object?> on T? {
  U let<U extends Object?>(U Function(T? it) callback) {
    return callback.call(this);
  }

  T? apply(void Function(T? it) callback) {
    callback.call(this);
    return this;
  }
}

extension ScopeExtension<T extends Object> on T {
  U let<U extends Object?>(U Function(T it) callback) {
    return callback.call(this);
  }

  T apply(void Function(T it) callback) {
    callback.call(this);
    return this;
  }
}
