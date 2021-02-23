// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ApiResultTearOff {
  const _$ApiResultTearOff();

  Loaded<T> fetched<T>({@required T data}) {
    return Loaded<T>(
      data: data,
    );
  }

  Init<T> init<T>() {
    return Init<T>();
  }
}

// ignore: unused_element
const $ApiResult = _$ApiResultTearOff();

mixin _$ApiResult<T> {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetched(T data),
    @required Result init(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetched(T data),
    Result init(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetched(Loaded<T> value),
    @required Result init(Init<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetched(Loaded<T> value),
    Result init(Init<T> value),
    @required Result orElse(),
  });
}

abstract class $ApiResultCopyWith<T, $Res> {
  factory $ApiResultCopyWith(
          ApiResult<T> value, $Res Function(ApiResult<T>) then) =
      _$ApiResultCopyWithImpl<T, $Res>;
}

class _$ApiResultCopyWithImpl<T, $Res> implements $ApiResultCopyWith<T, $Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  final ApiResult<T> _value;
  // ignore: unused_field
  final $Res Function(ApiResult<T>) _then;
}

abstract class $FetchedCopyWith<T, $Res> {
  factory $FetchedCopyWith(Loaded<T> value, $Res Function(Loaded<T>) then) =
      _$FetchedCopyWithImpl<T, $Res>;
  $Res call({T data});
}

class _$FetchedCopyWithImpl<T, $Res> extends _$ApiResultCopyWithImpl<T, $Res>
    implements $FetchedCopyWith<T, $Res> {
  _$FetchedCopyWithImpl(Loaded<T> _value, $Res Function(Loaded<T>) _then)
      : super(_value, (v) => _then(v as Loaded<T>));

  @override
  Loaded<T> get _value => super._value as Loaded<T>;

  @override
  $Res call({
    Object data = freezed,
  }) {
    return _then(Loaded<T>(
      data: data == freezed ? _value.data : data as T,
    ));
  }
}

class _$Fetched<T> with DiagnosticableTreeMixin implements Loaded<T> {
  const _$Fetched({@required this.data}) : assert(data != null);

  @override
  final T data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApiResult<$T>.fetched(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApiResult<$T>.fetched'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaded<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @override
  $FetchedCopyWith<T, Loaded<T>> get copyWith =>
      _$FetchedCopyWithImpl<T, Loaded<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetched(T data),
    @required Result init(),
  }) {
    assert(fetched != null);
    assert(init != null);
    return fetched(data);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetched(T data),
    Result init(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetched != null) {
      return fetched(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetched(Loaded<T> value),
    @required Result init(Init<T> value),
  }) {
    assert(fetched != null);
    assert(init != null);
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetched(Loaded<T> value),
    Result init(Init<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class Loaded<T> implements ApiResult<T> {
  const factory Loaded({@required T data}) = _$Fetched<T>;

  T get data;
  $FetchedCopyWith<T, Loaded<T>> get copyWith;
}

abstract class $InitCopyWith<T, $Res> {
  factory $InitCopyWith(Init<T> value, $Res Function(Init<T>) then) =
      _$InitCopyWithImpl<T, $Res>;
}

class _$InitCopyWithImpl<T, $Res> extends _$ApiResultCopyWithImpl<T, $Res>
    implements $InitCopyWith<T, $Res> {
  _$InitCopyWithImpl(Init<T> _value, $Res Function(Init<T>) _then)
      : super(_value, (v) => _then(v as Init<T>));

  @override
  Init<T> get _value => super._value as Init<T>;
}

class _$Init<T> with DiagnosticableTreeMixin implements Init<T> {
  const _$Init();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApiResult<$T>.init()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'ApiResult<$T>.init'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Init<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetched(T data),
    @required Result init(),
  }) {
    assert(fetched != null);
    assert(init != null);
    return init();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetched(T data),
    Result init(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetched(Loaded<T> value),
    @required Result init(Init<T> value),
  }) {
    assert(fetched != null);
    assert(init != null);
    return init(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetched(Loaded<T> value),
    Result init(Init<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class Init<T> implements ApiResult<T> {
  const factory Init() = _$Init<T>;
}
