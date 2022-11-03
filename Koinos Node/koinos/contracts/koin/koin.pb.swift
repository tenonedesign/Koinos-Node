// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/contracts/koin/koin.proto
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

struct Koinos_Contracts_Koin_mana_balance_object {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var balance: UInt64 = 0

  var mana: UInt64 = 0

  var lastManaUpdate: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_Contracts_Koin_mana_balance_object: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "koinos.contracts.koin"

extension Koinos_Contracts_Koin_mana_balance_object: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".mana_balance_object"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "balance"),
    2: .same(proto: "mana"),
    3: .standard(proto: "last_mana_update"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.balance) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.mana) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.lastManaUpdate) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.balance != 0 {
      try visitor.visitSingularUInt64Field(value: self.balance, fieldNumber: 1)
    }
    if self.mana != 0 {
      try visitor.visitSingularUInt64Field(value: self.mana, fieldNumber: 2)
    }
    if self.lastManaUpdate != 0 {
      try visitor.visitSingularUInt64Field(value: self.lastManaUpdate, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Koin_mana_balance_object, rhs: Koinos_Contracts_Koin_mana_balance_object) -> Bool {
    if lhs.balance != rhs.balance {return false}
    if lhs.mana != rhs.mana {return false}
    if lhs.lastManaUpdate != rhs.lastManaUpdate {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}