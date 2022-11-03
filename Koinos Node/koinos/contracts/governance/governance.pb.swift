// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/contracts/governance/governance.proto
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

enum Koinos_Contracts_Governance_proposal_status: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case pending // = 0
  case active // = 1
  case approved // = 2
  case expired // = 3
  case applied // = 4
  case failed // = 5
  case reverted // = 6
  case UNRECOGNIZED(Int)

  init() {
    self = .pending
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .pending
    case 1: self = .active
    case 2: self = .approved
    case 3: self = .expired
    case 4: self = .applied
    case 5: self = .failed
    case 6: self = .reverted
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .pending: return 0
    case .active: return 1
    case .approved: return 2
    case .expired: return 3
    case .applied: return 4
    case .failed: return 5
    case .reverted: return 6
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Koinos_Contracts_Governance_proposal_status: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Koinos_Contracts_Governance_proposal_status] = [
    .pending,
    .active,
    .approved,
    .expired,
    .applied,
    .failed,
    .reverted,
  ]
}

#endif  // swift(>=4.2)

struct Koinos_Contracts_Governance_proposal_record {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var operations: [Koinos_Protocol_operation] = []

  var operationMerkleRoot: Data = Data()

  var voteStartHeight: UInt64 = 0

  var voteTally: UInt64 = 0

  var voteThreshold: UInt64 = 0

  var shallAuthorize: Bool = false

  var updatesGovernance: Bool = false

  var status: Koinos_Contracts_Governance_proposal_status = .pending

  var fee: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_submit_proposal_arguments {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var operations: [Koinos_Protocol_operation] = []

  var operationMerkleRoot: Data = Data()

  var fee: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_submit_proposal_result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_get_proposal_by_id_arguments {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var proposalID: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_get_proposal_by_id_result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: Koinos_Contracts_Governance_proposal_record {
    get {return _value ?? Koinos_Contracts_Governance_proposal_record()}
    set {_value = newValue}
  }
  /// Returns true if `value` has been explicitly set.
  var hasValue: Bool {return self._value != nil}
  /// Clears the value of `value`. Subsequent reads from it will return its default value.
  mutating func clearValue() {self._value = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _value: Koinos_Contracts_Governance_proposal_record? = nil
}

struct Koinos_Contracts_Governance_get_proposals_by_status_arguments {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var startProposal: Data = Data()

  var limit: UInt64 = 0

  var status: Koinos_Contracts_Governance_proposal_status = .pending

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_get_proposals_by_status_result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: [Koinos_Contracts_Governance_proposal_record] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_get_proposals_arguments {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var startProposal: Data = Data()

  var limit: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_get_proposals_result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: [Koinos_Contracts_Governance_proposal_record] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_proposal_submission_event {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var proposal: Koinos_Contracts_Governance_proposal_record {
    get {return _proposal ?? Koinos_Contracts_Governance_proposal_record()}
    set {_proposal = newValue}
  }
  /// Returns true if `proposal` has been explicitly set.
  var hasProposal: Bool {return self._proposal != nil}
  /// Clears the value of `proposal`. Subsequent reads from it will return its default value.
  mutating func clearProposal() {self._proposal = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _proposal: Koinos_Contracts_Governance_proposal_record? = nil
}

struct Koinos_Contracts_Governance_proposal_status_event {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Data = Data()

  var status: Koinos_Contracts_Governance_proposal_status = .pending

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Contracts_Governance_proposal_vote_event {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Data = Data()

  var voteTally: UInt64 = 0

  var voteThreshold: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_Contracts_Governance_proposal_status: @unchecked Sendable {}
extension Koinos_Contracts_Governance_proposal_record: @unchecked Sendable {}
extension Koinos_Contracts_Governance_submit_proposal_arguments: @unchecked Sendable {}
extension Koinos_Contracts_Governance_submit_proposal_result: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposal_by_id_arguments: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposal_by_id_result: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposals_by_status_arguments: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposals_by_status_result: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposals_arguments: @unchecked Sendable {}
extension Koinos_Contracts_Governance_get_proposals_result: @unchecked Sendable {}
extension Koinos_Contracts_Governance_proposal_submission_event: @unchecked Sendable {}
extension Koinos_Contracts_Governance_proposal_status_event: @unchecked Sendable {}
extension Koinos_Contracts_Governance_proposal_vote_event: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "koinos.contracts.governance"

extension Koinos_Contracts_Governance_proposal_status: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "pending"),
    1: .same(proto: "active"),
    2: .same(proto: "approved"),
    3: .same(proto: "expired"),
    4: .same(proto: "applied"),
    5: .same(proto: "failed"),
    6: .same(proto: "reverted"),
  ]
}

extension Koinos_Contracts_Governance_proposal_record: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".proposal_record"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "operations"),
    2: .standard(proto: "operation_merkle_root"),
    3: .standard(proto: "vote_start_height"),
    4: .standard(proto: "vote_tally"),
    5: .standard(proto: "vote_threshold"),
    6: .standard(proto: "shall_authorize"),
    7: .standard(proto: "updates_governance"),
    8: .same(proto: "status"),
    9: .same(proto: "fee"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.operations) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.operationMerkleRoot) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.voteStartHeight) }()
      case 4: try { try decoder.decodeSingularUInt64Field(value: &self.voteTally) }()
      case 5: try { try decoder.decodeSingularUInt64Field(value: &self.voteThreshold) }()
      case 6: try { try decoder.decodeSingularBoolField(value: &self.shallAuthorize) }()
      case 7: try { try decoder.decodeSingularBoolField(value: &self.updatesGovernance) }()
      case 8: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      case 9: try { try decoder.decodeSingularUInt64Field(value: &self.fee) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.operations.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.operations, fieldNumber: 1)
    }
    if !self.operationMerkleRoot.isEmpty {
      try visitor.visitSingularBytesField(value: self.operationMerkleRoot, fieldNumber: 2)
    }
    if self.voteStartHeight != 0 {
      try visitor.visitSingularUInt64Field(value: self.voteStartHeight, fieldNumber: 3)
    }
    if self.voteTally != 0 {
      try visitor.visitSingularUInt64Field(value: self.voteTally, fieldNumber: 4)
    }
    if self.voteThreshold != 0 {
      try visitor.visitSingularUInt64Field(value: self.voteThreshold, fieldNumber: 5)
    }
    if self.shallAuthorize != false {
      try visitor.visitSingularBoolField(value: self.shallAuthorize, fieldNumber: 6)
    }
    if self.updatesGovernance != false {
      try visitor.visitSingularBoolField(value: self.updatesGovernance, fieldNumber: 7)
    }
    if self.status != .pending {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 8)
    }
    if self.fee != 0 {
      try visitor.visitSingularUInt64Field(value: self.fee, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_proposal_record, rhs: Koinos_Contracts_Governance_proposal_record) -> Bool {
    if lhs.operations != rhs.operations {return false}
    if lhs.operationMerkleRoot != rhs.operationMerkleRoot {return false}
    if lhs.voteStartHeight != rhs.voteStartHeight {return false}
    if lhs.voteTally != rhs.voteTally {return false}
    if lhs.voteThreshold != rhs.voteThreshold {return false}
    if lhs.shallAuthorize != rhs.shallAuthorize {return false}
    if lhs.updatesGovernance != rhs.updatesGovernance {return false}
    if lhs.status != rhs.status {return false}
    if lhs.fee != rhs.fee {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_submit_proposal_arguments: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".submit_proposal_arguments"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "operations"),
    2: .standard(proto: "operation_merkle_root"),
    3: .same(proto: "fee"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.operations) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.operationMerkleRoot) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.fee) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.operations.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.operations, fieldNumber: 1)
    }
    if !self.operationMerkleRoot.isEmpty {
      try visitor.visitSingularBytesField(value: self.operationMerkleRoot, fieldNumber: 2)
    }
    if self.fee != 0 {
      try visitor.visitSingularUInt64Field(value: self.fee, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_submit_proposal_arguments, rhs: Koinos_Contracts_Governance_submit_proposal_arguments) -> Bool {
    if lhs.operations != rhs.operations {return false}
    if lhs.operationMerkleRoot != rhs.operationMerkleRoot {return false}
    if lhs.fee != rhs.fee {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_submit_proposal_result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".submit_proposal_result"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_submit_proposal_result, rhs: Koinos_Contracts_Governance_submit_proposal_result) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposal_by_id_arguments: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposal_by_id_arguments"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "proposal_id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.proposalID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.proposalID.isEmpty {
      try visitor.visitSingularBytesField(value: self.proposalID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposal_by_id_arguments, rhs: Koinos_Contracts_Governance_get_proposal_by_id_arguments) -> Bool {
    if lhs.proposalID != rhs.proposalID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposal_by_id_result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposal_by_id_result"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._value) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._value {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposal_by_id_result, rhs: Koinos_Contracts_Governance_get_proposal_by_id_result) -> Bool {
    if lhs._value != rhs._value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposals_by_status_arguments: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposals_by_status_arguments"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "start_proposal"),
    2: .same(proto: "limit"),
    3: .same(proto: "status"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.startProposal) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.limit) }()
      case 3: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.startProposal.isEmpty {
      try visitor.visitSingularBytesField(value: self.startProposal, fieldNumber: 1)
    }
    if self.limit != 0 {
      try visitor.visitSingularUInt64Field(value: self.limit, fieldNumber: 2)
    }
    if self.status != .pending {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposals_by_status_arguments, rhs: Koinos_Contracts_Governance_get_proposals_by_status_arguments) -> Bool {
    if lhs.startProposal != rhs.startProposal {return false}
    if lhs.limit != rhs.limit {return false}
    if lhs.status != rhs.status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposals_by_status_result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposals_by_status_result"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.value) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposals_by_status_result, rhs: Koinos_Contracts_Governance_get_proposals_by_status_result) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposals_arguments: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposals_arguments"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "start_proposal"),
    2: .same(proto: "limit"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.startProposal) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.limit) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.startProposal.isEmpty {
      try visitor.visitSingularBytesField(value: self.startProposal, fieldNumber: 1)
    }
    if self.limit != 0 {
      try visitor.visitSingularUInt64Field(value: self.limit, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposals_arguments, rhs: Koinos_Contracts_Governance_get_proposals_arguments) -> Bool {
    if lhs.startProposal != rhs.startProposal {return false}
    if lhs.limit != rhs.limit {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_get_proposals_result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_proposals_result"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.value) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_get_proposals_result, rhs: Koinos_Contracts_Governance_get_proposals_result) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_proposal_submission_event: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".proposal_submission_event"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "proposal"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._proposal) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._proposal {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_proposal_submission_event, rhs: Koinos_Contracts_Governance_proposal_submission_event) -> Bool {
    if lhs._proposal != rhs._proposal {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_proposal_status_event: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".proposal_status_event"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "status"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularBytesField(value: self.id, fieldNumber: 1)
    }
    if self.status != .pending {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_proposal_status_event, rhs: Koinos_Contracts_Governance_proposal_status_event) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.status != rhs.status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Contracts_Governance_proposal_vote_event: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".proposal_vote_event"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .standard(proto: "vote_tally"),
    3: .standard(proto: "vote_threshold"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.voteTally) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.voteThreshold) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularBytesField(value: self.id, fieldNumber: 1)
    }
    if self.voteTally != 0 {
      try visitor.visitSingularUInt64Field(value: self.voteTally, fieldNumber: 2)
    }
    if self.voteThreshold != 0 {
      try visitor.visitSingularUInt64Field(value: self.voteThreshold, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Contracts_Governance_proposal_vote_event, rhs: Koinos_Contracts_Governance_proposal_vote_event) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.voteTally != rhs.voteTally {return false}
    if lhs.voteThreshold != rhs.voteThreshold {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}