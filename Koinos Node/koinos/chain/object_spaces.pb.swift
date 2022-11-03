// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/chain/object_spaces.proto
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

enum Koinos_Chain_system_space_id: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case metadata // = 0
  case systemCallDispatch // = 1
  case contractBytecode // = 2
  case contractMetadata // = 3
  case transactionNonce // = 4
  case UNRECOGNIZED(Int)

  init() {
    self = .metadata
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .metadata
    case 1: self = .systemCallDispatch
    case 2: self = .contractBytecode
    case 3: self = .contractMetadata
    case 4: self = .transactionNonce
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .metadata: return 0
    case .systemCallDispatch: return 1
    case .contractBytecode: return 2
    case .contractMetadata: return 3
    case .transactionNonce: return 4
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Koinos_Chain_system_space_id: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Koinos_Chain_system_space_id] = [
    .metadata,
    .systemCallDispatch,
    .contractBytecode,
    .contractMetadata,
    .transactionNonce,
  ]
}

#endif  // swift(>=4.2)

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_Chain_system_space_id: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Koinos_Chain_system_space_id: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "metadata"),
    1: .same(proto: "system_call_dispatch"),
    2: .same(proto: "contract_bytecode"),
    3: .same(proto: "contract_metadata"),
    4: .same(proto: "transaction_nonce"),
  ]
}