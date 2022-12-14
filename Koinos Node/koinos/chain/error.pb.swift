// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/chain/error.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Koinos_Chain_error_code: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case success // = 0

  /// Reversions
  case reversion // = 1
  case internalError // = 100
  case systemAuthorizationFailure // = 101
  case invalidContract // = 102
  case insufficientPrivileges // = 103
  case insufficientRc // = 104
  case insufficientReturnBuffer // = 105
  case unknownThunk // = 106
  case unknownOperation // = 107
  case readOnlyContext // = 108

  /// Failures
  case failure // = -1
  case fieldNotFound // = -100
  case unknownHashCode // = -101
  case unknownDsa // = -102
  case unknownSystemCall // = -103
  case operationNotFound // = -104
  case authorizationFailure // = -200
  case invalidNonce // = -201
  case invalidSignature // = -202
  case malformedBlock // = -203
  case malformedTransaction // = -204
  case blockResourceFailure // = -205

  /// Framework failures
  case unknownBackend // = -1000
  case unexpectedState // = -1001
  case missingRequiredArguments // = -1002
  case unknownPreviousBlock // = -1003
  case unexpectedHeight // = -1004
  case blockStateError // = -1005
  case stateMerkleMismatch // = -1006
  case unexpectedReceipt // = -1007
  case rpcFailure // = -1008
  case pendingStateError // = -1009
  case timestampOutOfBounds // = -1010
  case indexerFailure // = -1011
  case networkBandwidthLimitExceeded // = -1012
  case computeBandwidthLimitExceeded // = -1013
  case diskStorageLimitExceeded // = -1014
  case preIrreversibilityBlock // = -1015
  case UNRECOGNIZED(Int)

  init() {
    self = .success
  }

  init?(rawValue: Int) {
    switch rawValue {
    case -1015: self = .preIrreversibilityBlock
    case -1014: self = .diskStorageLimitExceeded
    case -1013: self = .computeBandwidthLimitExceeded
    case -1012: self = .networkBandwidthLimitExceeded
    case -1011: self = .indexerFailure
    case -1010: self = .timestampOutOfBounds
    case -1009: self = .pendingStateError
    case -1008: self = .rpcFailure
    case -1007: self = .unexpectedReceipt
    case -1006: self = .stateMerkleMismatch
    case -1005: self = .blockStateError
    case -1004: self = .unexpectedHeight
    case -1003: self = .unknownPreviousBlock
    case -1002: self = .missingRequiredArguments
    case -1001: self = .unexpectedState
    case -1000: self = .unknownBackend
    case -205: self = .blockResourceFailure
    case -204: self = .malformedTransaction
    case -203: self = .malformedBlock
    case -202: self = .invalidSignature
    case -201: self = .invalidNonce
    case -200: self = .authorizationFailure
    case -104: self = .operationNotFound
    case -103: self = .unknownSystemCall
    case -102: self = .unknownDsa
    case -101: self = .unknownHashCode
    case -100: self = .fieldNotFound
    case -1: self = .failure
    case 0: self = .success
    case 1: self = .reversion
    case 100: self = .internalError
    case 101: self = .systemAuthorizationFailure
    case 102: self = .invalidContract
    case 103: self = .insufficientPrivileges
    case 104: self = .insufficientRc
    case 105: self = .insufficientReturnBuffer
    case 106: self = .unknownThunk
    case 107: self = .unknownOperation
    case 108: self = .readOnlyContext
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .preIrreversibilityBlock: return -1015
    case .diskStorageLimitExceeded: return -1014
    case .computeBandwidthLimitExceeded: return -1013
    case .networkBandwidthLimitExceeded: return -1012
    case .indexerFailure: return -1011
    case .timestampOutOfBounds: return -1010
    case .pendingStateError: return -1009
    case .rpcFailure: return -1008
    case .unexpectedReceipt: return -1007
    case .stateMerkleMismatch: return -1006
    case .blockStateError: return -1005
    case .unexpectedHeight: return -1004
    case .unknownPreviousBlock: return -1003
    case .missingRequiredArguments: return -1002
    case .unexpectedState: return -1001
    case .unknownBackend: return -1000
    case .blockResourceFailure: return -205
    case .malformedTransaction: return -204
    case .malformedBlock: return -203
    case .invalidSignature: return -202
    case .invalidNonce: return -201
    case .authorizationFailure: return -200
    case .operationNotFound: return -104
    case .unknownSystemCall: return -103
    case .unknownDsa: return -102
    case .unknownHashCode: return -101
    case .fieldNotFound: return -100
    case .failure: return -1
    case .success: return 0
    case .reversion: return 1
    case .internalError: return 100
    case .systemAuthorizationFailure: return 101
    case .invalidContract: return 102
    case .insufficientPrivileges: return 103
    case .insufficientRc: return 104
    case .insufficientReturnBuffer: return 105
    case .unknownThunk: return 106
    case .unknownOperation: return 107
    case .readOnlyContext: return 108
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Koinos_Chain_error_code: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Koinos_Chain_error_code] = [
    .success,
    .reversion,
    .internalError,
    .systemAuthorizationFailure,
    .invalidContract,
    .insufficientPrivileges,
    .insufficientRc,
    .insufficientReturnBuffer,
    .unknownThunk,
    .unknownOperation,
    .readOnlyContext,
    .failure,
    .fieldNotFound,
    .unknownHashCode,
    .unknownDsa,
    .unknownSystemCall,
    .operationNotFound,
    .authorizationFailure,
    .invalidNonce,
    .invalidSignature,
    .malformedBlock,
    .malformedTransaction,
    .blockResourceFailure,
    .unknownBackend,
    .unexpectedState,
    .missingRequiredArguments,
    .unknownPreviousBlock,
    .unexpectedHeight,
    .blockStateError,
    .stateMerkleMismatch,
    .unexpectedReceipt,
    .rpcFailure,
    .pendingStateError,
    .timestampOutOfBounds,
    .indexerFailure,
    .networkBandwidthLimitExceeded,
    .computeBandwidthLimitExceeded,
    .diskStorageLimitExceeded,
    .preIrreversibilityBlock,
  ]
}

#endif  // swift(>=4.2)

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_Chain_error_code: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Koinos_Chain_error_code: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    -1015: .same(proto: "pre_irreversibility_block"),
    -1014: .same(proto: "disk_storage_limit_exceeded"),
    -1013: .same(proto: "compute_bandwidth_limit_exceeded"),
    -1012: .same(proto: "network_bandwidth_limit_exceeded"),
    -1011: .same(proto: "indexer_failure"),
    -1010: .same(proto: "timestamp_out_of_bounds"),
    -1009: .same(proto: "pending_state_error"),
    -1008: .same(proto: "rpc_failure"),
    -1007: .same(proto: "unexpected_receipt"),
    -1006: .same(proto: "state_merkle_mismatch"),
    -1005: .same(proto: "block_state_error"),
    -1004: .same(proto: "unexpected_height"),
    -1003: .same(proto: "unknown_previous_block"),
    -1002: .same(proto: "missing_required_arguments"),
    -1001: .same(proto: "unexpected_state"),
    -1000: .same(proto: "unknown_backend"),
    -205: .same(proto: "block_resource_failure"),
    -204: .same(proto: "malformed_transaction"),
    -203: .same(proto: "malformed_block"),
    -202: .same(proto: "invalid_signature"),
    -201: .same(proto: "invalid_nonce"),
    -200: .same(proto: "authorization_failure"),
    -104: .same(proto: "operation_not_found"),
    -103: .same(proto: "unknown_system_call"),
    -102: .same(proto: "unknown_dsa"),
    -101: .same(proto: "unknown_hash_code"),
    -100: .same(proto: "field_not_found"),
    -1: .same(proto: "failure"),
    0: .same(proto: "success"),
    1: .same(proto: "reversion"),
    100: .same(proto: "internal_error"),
    101: .same(proto: "system_authorization_failure"),
    102: .same(proto: "invalid_contract"),
    103: .same(proto: "insufficient_privileges"),
    104: .same(proto: "insufficient_rc"),
    105: .same(proto: "insufficient_return_buffer"),
    106: .same(proto: "unknown_thunk"),
    107: .same(proto: "unknown_operation"),
    108: .same(proto: "read_only_context"),
  ]
}
