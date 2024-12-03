// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppAuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthentication,
    required TResult Function() logout,
    required TResult Function() sessionExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthentication,
    TResult? Function()? logout,
    TResult? Function()? sessionExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthentication,
    TResult Function()? logout,
    TResult Function()? sessionExpired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthenticationAppEvent value)
        checkAuthentication,
    required TResult Function(LogoutAppEvent value) logout,
    required TResult Function(SessionExpiredAppEvent value) sessionExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult? Function(LogoutAppEvent value)? logout,
    TResult? Function(SessionExpiredAppEvent value)? sessionExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult Function(LogoutAppEvent value)? logout,
    TResult Function(SessionExpiredAppEvent value)? sessionExpired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppAuthEventCopyWith<$Res> {
  factory $AppAuthEventCopyWith(
          AppAuthEvent value, $Res Function(AppAuthEvent) then) =
      _$AppAuthEventCopyWithImpl<$Res, AppAuthEvent>;
}

/// @nodoc
class _$AppAuthEventCopyWithImpl<$Res, $Val extends AppAuthEvent>
    implements $AppAuthEventCopyWith<$Res> {
  _$AppAuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppAuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckAuthenticationAppEventImplCopyWith<$Res> {
  factory _$$CheckAuthenticationAppEventImplCopyWith(
          _$CheckAuthenticationAppEventImpl value,
          $Res Function(_$CheckAuthenticationAppEventImpl) then) =
      __$$CheckAuthenticationAppEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthenticationAppEventImplCopyWithImpl<$Res>
    extends _$AppAuthEventCopyWithImpl<$Res, _$CheckAuthenticationAppEventImpl>
    implements _$$CheckAuthenticationAppEventImplCopyWith<$Res> {
  __$$CheckAuthenticationAppEventImplCopyWithImpl(
      _$CheckAuthenticationAppEventImpl _value,
      $Res Function(_$CheckAuthenticationAppEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckAuthenticationAppEventImpl implements CheckAuthenticationAppEvent {
  const _$CheckAuthenticationAppEventImpl();

  @override
  String toString() {
    return 'AppAuthEvent.checkAuthentication()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckAuthenticationAppEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthentication,
    required TResult Function() logout,
    required TResult Function() sessionExpired,
  }) {
    return checkAuthentication();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthentication,
    TResult? Function()? logout,
    TResult? Function()? sessionExpired,
  }) {
    return checkAuthentication?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthentication,
    TResult Function()? logout,
    TResult Function()? sessionExpired,
    required TResult orElse(),
  }) {
    if (checkAuthentication != null) {
      return checkAuthentication();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthenticationAppEvent value)
        checkAuthentication,
    required TResult Function(LogoutAppEvent value) logout,
    required TResult Function(SessionExpiredAppEvent value) sessionExpired,
  }) {
    return checkAuthentication(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult? Function(LogoutAppEvent value)? logout,
    TResult? Function(SessionExpiredAppEvent value)? sessionExpired,
  }) {
    return checkAuthentication?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult Function(LogoutAppEvent value)? logout,
    TResult Function(SessionExpiredAppEvent value)? sessionExpired,
    required TResult orElse(),
  }) {
    if (checkAuthentication != null) {
      return checkAuthentication(this);
    }
    return orElse();
  }
}

abstract class CheckAuthenticationAppEvent implements AppAuthEvent {
  const factory CheckAuthenticationAppEvent() =
      _$CheckAuthenticationAppEventImpl;
}

/// @nodoc
abstract class _$$LogoutAppEventImplCopyWith<$Res> {
  factory _$$LogoutAppEventImplCopyWith(_$LogoutAppEventImpl value,
          $Res Function(_$LogoutAppEventImpl) then) =
      __$$LogoutAppEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutAppEventImplCopyWithImpl<$Res>
    extends _$AppAuthEventCopyWithImpl<$Res, _$LogoutAppEventImpl>
    implements _$$LogoutAppEventImplCopyWith<$Res> {
  __$$LogoutAppEventImplCopyWithImpl(
      _$LogoutAppEventImpl _value, $Res Function(_$LogoutAppEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutAppEventImpl implements LogoutAppEvent {
  const _$LogoutAppEventImpl();

  @override
  String toString() {
    return 'AppAuthEvent.logout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutAppEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthentication,
    required TResult Function() logout,
    required TResult Function() sessionExpired,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthentication,
    TResult? Function()? logout,
    TResult? Function()? sessionExpired,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthentication,
    TResult Function()? logout,
    TResult Function()? sessionExpired,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthenticationAppEvent value)
        checkAuthentication,
    required TResult Function(LogoutAppEvent value) logout,
    required TResult Function(SessionExpiredAppEvent value) sessionExpired,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult? Function(LogoutAppEvent value)? logout,
    TResult? Function(SessionExpiredAppEvent value)? sessionExpired,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult Function(LogoutAppEvent value)? logout,
    TResult Function(SessionExpiredAppEvent value)? sessionExpired,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class LogoutAppEvent implements AppAuthEvent {
  const factory LogoutAppEvent() = _$LogoutAppEventImpl;
}

/// @nodoc
abstract class _$$SessionExpiredAppEventImplCopyWith<$Res> {
  factory _$$SessionExpiredAppEventImplCopyWith(
          _$SessionExpiredAppEventImpl value,
          $Res Function(_$SessionExpiredAppEventImpl) then) =
      __$$SessionExpiredAppEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionExpiredAppEventImplCopyWithImpl<$Res>
    extends _$AppAuthEventCopyWithImpl<$Res, _$SessionExpiredAppEventImpl>
    implements _$$SessionExpiredAppEventImplCopyWith<$Res> {
  __$$SessionExpiredAppEventImplCopyWithImpl(
      _$SessionExpiredAppEventImpl _value,
      $Res Function(_$SessionExpiredAppEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionExpiredAppEventImpl implements SessionExpiredAppEvent {
  const _$SessionExpiredAppEventImpl();

  @override
  String toString() {
    return 'AppAuthEvent.sessionExpired()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionExpiredAppEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthentication,
    required TResult Function() logout,
    required TResult Function() sessionExpired,
  }) {
    return sessionExpired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthentication,
    TResult? Function()? logout,
    TResult? Function()? sessionExpired,
  }) {
    return sessionExpired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthentication,
    TResult Function()? logout,
    TResult Function()? sessionExpired,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckAuthenticationAppEvent value)
        checkAuthentication,
    required TResult Function(LogoutAppEvent value) logout,
    required TResult Function(SessionExpiredAppEvent value) sessionExpired,
  }) {
    return sessionExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult? Function(LogoutAppEvent value)? logout,
    TResult? Function(SessionExpiredAppEvent value)? sessionExpired,
  }) {
    return sessionExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckAuthenticationAppEvent value)? checkAuthentication,
    TResult Function(LogoutAppEvent value)? logout,
    TResult Function(SessionExpiredAppEvent value)? sessionExpired,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired(this);
    }
    return orElse();
  }
}

abstract class SessionExpiredAppEvent implements AppAuthEvent {
  const factory SessionExpiredAppEvent() = _$SessionExpiredAppEventImpl;
}

/// @nodoc
mixin _$AppAuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppAuthStateCopyWith<$Res> {
  factory $AppAuthStateCopyWith(
          AppAuthState value, $Res Function(AppAuthState) then) =
      _$AppAuthStateCopyWithImpl<$Res, AppAuthState>;
}

/// @nodoc
class _$AppAuthStateCopyWithImpl<$Res, $Val extends AppAuthState>
    implements $AppAuthStateCopyWith<$Res> {
  _$AppAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnAuthenticatedStateImplCopyWith<$Res> {
  factory _$$UnAuthenticatedStateImplCopyWith(_$UnAuthenticatedStateImpl value,
          $Res Function(_$UnAuthenticatedStateImpl) then) =
      __$$UnAuthenticatedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnAuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AppAuthStateCopyWithImpl<$Res, _$UnAuthenticatedStateImpl>
    implements _$$UnAuthenticatedStateImplCopyWith<$Res> {
  __$$UnAuthenticatedStateImplCopyWithImpl(_$UnAuthenticatedStateImpl _value,
      $Res Function(_$UnAuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnAuthenticatedStateImpl implements UnAuthenticatedState {
  const _$UnAuthenticatedStateImpl();

  @override
  String toString() {
    return 'AppAuthState.unAuthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnAuthenticatedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) {
    return unAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) {
    return unAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class UnAuthenticatedState implements AppAuthState {
  const factory UnAuthenticatedState() = _$UnAuthenticatedStateImpl;
}

/// @nodoc
abstract class _$$AuthenticatedStateImplCopyWith<$Res> {
  factory _$$AuthenticatedStateImplCopyWith(_$AuthenticatedStateImpl value,
          $Res Function(_$AuthenticatedStateImpl) then) =
      __$$AuthenticatedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AppAuthStateCopyWithImpl<$Res, _$AuthenticatedStateImpl>
    implements _$$AuthenticatedStateImplCopyWith<$Res> {
  __$$AuthenticatedStateImplCopyWithImpl(_$AuthenticatedStateImpl _value,
      $Res Function(_$AuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticatedStateImpl implements AuthenticatedState {
  const _$AuthenticatedStateImpl();

  @override
  String toString() {
    return 'AppAuthState.authenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedState implements AppAuthState {
  const factory AuthenticatedState() = _$AuthenticatedStateImpl;
}

/// @nodoc
abstract class _$$LoggingOutStateImplCopyWith<$Res> {
  factory _$$LoggingOutStateImplCopyWith(_$LoggingOutStateImpl value,
          $Res Function(_$LoggingOutStateImpl) then) =
      __$$LoggingOutStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggingOutStateImplCopyWithImpl<$Res>
    extends _$AppAuthStateCopyWithImpl<$Res, _$LoggingOutStateImpl>
    implements _$$LoggingOutStateImplCopyWith<$Res> {
  __$$LoggingOutStateImplCopyWithImpl(
      _$LoggingOutStateImpl _value, $Res Function(_$LoggingOutStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggingOutStateImpl implements LoggingOutState {
  const _$LoggingOutStateImpl();

  @override
  String toString() {
    return 'AppAuthState.loggingOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggingOutStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) {
    return loggingOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) {
    return loggingOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return loggingOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return loggingOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut(this);
    }
    return orElse();
  }
}

abstract class LoggingOutState implements AppAuthState {
  const factory LoggingOutState() = _$LoggingOutStateImpl;
}

/// @nodoc
abstract class _$$SessionExpiredStateImplCopyWith<$Res> {
  factory _$$SessionExpiredStateImplCopyWith(_$SessionExpiredStateImpl value,
          $Res Function(_$SessionExpiredStateImpl) then) =
      __$$SessionExpiredStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionExpiredStateImplCopyWithImpl<$Res>
    extends _$AppAuthStateCopyWithImpl<$Res, _$SessionExpiredStateImpl>
    implements _$$SessionExpiredStateImplCopyWith<$Res> {
  __$$SessionExpiredStateImplCopyWithImpl(_$SessionExpiredStateImpl _value,
      $Res Function(_$SessionExpiredStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionExpiredStateImpl implements SessionExpiredState {
  const _$SessionExpiredStateImpl();

  @override
  String toString() {
    return 'AppAuthState.sessionExpired()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionExpiredStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) {
    return sessionExpired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) {
    return sessionExpired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return sessionExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return sessionExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (sessionExpired != null) {
      return sessionExpired(this);
    }
    return orElse();
  }
}

abstract class SessionExpiredState implements AppAuthState {
  const factory SessionExpiredState() = _$SessionExpiredStateImpl;
}

/// @nodoc
abstract class _$$LoggedOutStateImplCopyWith<$Res> {
  factory _$$LoggedOutStateImplCopyWith(_$LoggedOutStateImpl value,
          $Res Function(_$LoggedOutStateImpl) then) =
      __$$LoggedOutStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutStateImplCopyWithImpl<$Res>
    extends _$AppAuthStateCopyWithImpl<$Res, _$LoggedOutStateImpl>
    implements _$$LoggedOutStateImplCopyWith<$Res> {
  __$$LoggedOutStateImplCopyWithImpl(
      _$LoggedOutStateImpl _value, $Res Function(_$LoggedOutStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppAuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggedOutStateImpl implements LoggedOutState {
  const _$LoggedOutStateImpl();

  @override
  String toString() {
    return 'AppAuthState.loggedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOutStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function() authenticated,
    required TResult Function() loggingOut,
    required TResult Function() sessionExpired,
    required TResult Function() loggedOut,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? loggingOut,
    TResult? Function()? sessionExpired,
    TResult? Function()? loggedOut,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function()? authenticated,
    TResult Function()? loggingOut,
    TResult Function()? sessionExpired,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnAuthenticatedState value) unAuthenticated,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(LoggingOutState value) loggingOut,
    required TResult Function(SessionExpiredState value) sessionExpired,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnAuthenticatedState value)? unAuthenticated,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(LoggingOutState value)? loggingOut,
    TResult? Function(SessionExpiredState value)? sessionExpired,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnAuthenticatedState value)? unAuthenticated,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(LoggingOutState value)? loggingOut,
    TResult Function(SessionExpiredState value)? sessionExpired,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class LoggedOutState implements AppAuthState {
  const factory LoggedOutState() = _$LoggedOutStateImpl;
}
