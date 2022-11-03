// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/rpc/block_store/block_store_rpc.proto
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

struct Koinos_Rpc_BlockStore_get_blocks_by_id_request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockIds: [Data] = []

  var returnBlock: Bool = false

  var returnReceipt: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_get_blocks_by_id_response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockItems: [Koinos_BlockStore_block_item] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_get_blocks_by_height_request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var headBlockID: Data = Data()

  var ancestorStartHeight: UInt64 = 0

  var numBlocks: UInt32 = 0

  var returnBlock: Bool = false

  var returnReceipt: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_get_blocks_by_height_response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockItems: [Koinos_BlockStore_block_item] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_add_block_request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockToAdd: Koinos_Protocol_block {
    get {return _storage._blockToAdd ?? Koinos_Protocol_block()}
    set {_uniqueStorage()._blockToAdd = newValue}
  }
  /// Returns true if `blockToAdd` has been explicitly set.
  var hasBlockToAdd: Bool {return _storage._blockToAdd != nil}
  /// Clears the value of `blockToAdd`. Subsequent reads from it will return its default value.
  mutating func clearBlockToAdd() {_uniqueStorage()._blockToAdd = nil}

  var receiptToAdd: Koinos_Protocol_block_receipt {
    get {return _storage._receiptToAdd ?? Koinos_Protocol_block_receipt()}
    set {_uniqueStorage()._receiptToAdd = newValue}
  }
  /// Returns true if `receiptToAdd` has been explicitly set.
  var hasReceiptToAdd: Bool {return _storage._receiptToAdd != nil}
  /// Clears the value of `receiptToAdd`. Subsequent reads from it will return its default value.
  mutating func clearReceiptToAdd() {_uniqueStorage()._receiptToAdd = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Koinos_Rpc_BlockStore_add_block_response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_get_highest_block_request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Koinos_Rpc_BlockStore_get_highest_block_response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var topology: Koinos_block_topology {
    get {return _topology ?? Koinos_block_topology()}
    set {_topology = newValue}
  }
  /// Returns true if `topology` has been explicitly set.
  var hasTopology: Bool {return self._topology != nil}
  /// Clears the value of `topology`. Subsequent reads from it will return its default value.
  mutating func clearTopology() {self._topology = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _topology: Koinos_block_topology? = nil
}

struct Koinos_Rpc_BlockStore_block_store_request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var request: Koinos_Rpc_BlockStore_block_store_request.OneOf_Request? = nil

  var reserved: Koinos_Rpc_reserved_rpc {
    get {
      if case .reserved(let v)? = request {return v}
      return Koinos_Rpc_reserved_rpc()
    }
    set {request = .reserved(newValue)}
  }

  var getBlocksByID: Koinos_Rpc_BlockStore_get_blocks_by_id_request {
    get {
      if case .getBlocksByID(let v)? = request {return v}
      return Koinos_Rpc_BlockStore_get_blocks_by_id_request()
    }
    set {request = .getBlocksByID(newValue)}
  }

  var getBlocksByHeight: Koinos_Rpc_BlockStore_get_blocks_by_height_request {
    get {
      if case .getBlocksByHeight(let v)? = request {return v}
      return Koinos_Rpc_BlockStore_get_blocks_by_height_request()
    }
    set {request = .getBlocksByHeight(newValue)}
  }

  var addBlock: Koinos_Rpc_BlockStore_add_block_request {
    get {
      if case .addBlock(let v)? = request {return v}
      return Koinos_Rpc_BlockStore_add_block_request()
    }
    set {request = .addBlock(newValue)}
  }

  var getHighestBlock: Koinos_Rpc_BlockStore_get_highest_block_request {
    get {
      if case .getHighestBlock(let v)? = request {return v}
      return Koinos_Rpc_BlockStore_get_highest_block_request()
    }
    set {request = .getHighestBlock(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Request: Equatable {
    case reserved(Koinos_Rpc_reserved_rpc)
    case getBlocksByID(Koinos_Rpc_BlockStore_get_blocks_by_id_request)
    case getBlocksByHeight(Koinos_Rpc_BlockStore_get_blocks_by_height_request)
    case addBlock(Koinos_Rpc_BlockStore_add_block_request)
    case getHighestBlock(Koinos_Rpc_BlockStore_get_highest_block_request)

  #if !swift(>=4.1)
    static func ==(lhs: Koinos_Rpc_BlockStore_block_store_request.OneOf_Request, rhs: Koinos_Rpc_BlockStore_block_store_request.OneOf_Request) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.reserved, .reserved): return {
        guard case .reserved(let l) = lhs, case .reserved(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getBlocksByID, .getBlocksByID): return {
        guard case .getBlocksByID(let l) = lhs, case .getBlocksByID(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getBlocksByHeight, .getBlocksByHeight): return {
        guard case .getBlocksByHeight(let l) = lhs, case .getBlocksByHeight(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.addBlock, .addBlock): return {
        guard case .addBlock(let l) = lhs, case .addBlock(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getHighestBlock, .getHighestBlock): return {
        guard case .getHighestBlock(let l) = lhs, case .getHighestBlock(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

struct Koinos_Rpc_BlockStore_block_store_response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var response: Koinos_Rpc_BlockStore_block_store_response.OneOf_Response? = nil

  var reserved: Koinos_Rpc_reserved_rpc {
    get {
      if case .reserved(let v)? = response {return v}
      return Koinos_Rpc_reserved_rpc()
    }
    set {response = .reserved(newValue)}
  }

  var error: Koinos_Rpc_error_response {
    get {
      if case .error(let v)? = response {return v}
      return Koinos_Rpc_error_response()
    }
    set {response = .error(newValue)}
  }

  var getBlocksByID: Koinos_Rpc_BlockStore_get_blocks_by_id_response {
    get {
      if case .getBlocksByID(let v)? = response {return v}
      return Koinos_Rpc_BlockStore_get_blocks_by_id_response()
    }
    set {response = .getBlocksByID(newValue)}
  }

  var getBlocksByHeight: Koinos_Rpc_BlockStore_get_blocks_by_height_response {
    get {
      if case .getBlocksByHeight(let v)? = response {return v}
      return Koinos_Rpc_BlockStore_get_blocks_by_height_response()
    }
    set {response = .getBlocksByHeight(newValue)}
  }

  var addBlock: Koinos_Rpc_BlockStore_add_block_response {
    get {
      if case .addBlock(let v)? = response {return v}
      return Koinos_Rpc_BlockStore_add_block_response()
    }
    set {response = .addBlock(newValue)}
  }

  var getHighestBlock: Koinos_Rpc_BlockStore_get_highest_block_response {
    get {
      if case .getHighestBlock(let v)? = response {return v}
      return Koinos_Rpc_BlockStore_get_highest_block_response()
    }
    set {response = .getHighestBlock(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Response: Equatable {
    case reserved(Koinos_Rpc_reserved_rpc)
    case error(Koinos_Rpc_error_response)
    case getBlocksByID(Koinos_Rpc_BlockStore_get_blocks_by_id_response)
    case getBlocksByHeight(Koinos_Rpc_BlockStore_get_blocks_by_height_response)
    case addBlock(Koinos_Rpc_BlockStore_add_block_response)
    case getHighestBlock(Koinos_Rpc_BlockStore_get_highest_block_response)

  #if !swift(>=4.1)
    static func ==(lhs: Koinos_Rpc_BlockStore_block_store_response.OneOf_Response, rhs: Koinos_Rpc_BlockStore_block_store_response.OneOf_Response) -> Bool {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch (lhs, rhs) {
      case (.reserved, .reserved): return {
        guard case .reserved(let l) = lhs, case .reserved(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.error, .error): return {
        guard case .error(let l) = lhs, case .error(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getBlocksByID, .getBlocksByID): return {
        guard case .getBlocksByID(let l) = lhs, case .getBlocksByID(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getBlocksByHeight, .getBlocksByHeight): return {
        guard case .getBlocksByHeight(let l) = lhs, case .getBlocksByHeight(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.addBlock, .addBlock): return {
        guard case .addBlock(let l) = lhs, case .addBlock(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      case (.getHighestBlock, .getHighestBlock): return {
        guard case .getHighestBlock(let l) = lhs, case .getHighestBlock(let r) = rhs else { preconditionFailure() }
        return l == r
      }()
      default: return false
      }
    }
  #endif
  }

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_Rpc_BlockStore_get_blocks_by_id_request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_get_blocks_by_id_response: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_get_blocks_by_height_request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_get_blocks_by_height_response: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_add_block_request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_add_block_response: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_get_highest_block_request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_get_highest_block_response: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_block_store_request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_block_store_request.OneOf_Request: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_block_store_response: @unchecked Sendable {}
extension Koinos_Rpc_BlockStore_block_store_response.OneOf_Response: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "koinos.rpc.block_store"

extension Koinos_Rpc_BlockStore_get_blocks_by_id_request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_blocks_by_id_request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_ids"),
    2: .standard(proto: "return_block"),
    3: .standard(proto: "return_receipt"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedBytesField(value: &self.blockIds) }()
      case 2: try { try decoder.decodeSingularBoolField(value: &self.returnBlock) }()
      case 3: try { try decoder.decodeSingularBoolField(value: &self.returnReceipt) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockIds.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.blockIds, fieldNumber: 1)
    }
    if self.returnBlock != false {
      try visitor.visitSingularBoolField(value: self.returnBlock, fieldNumber: 2)
    }
    if self.returnReceipt != false {
      try visitor.visitSingularBoolField(value: self.returnReceipt, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_blocks_by_id_request, rhs: Koinos_Rpc_BlockStore_get_blocks_by_id_request) -> Bool {
    if lhs.blockIds != rhs.blockIds {return false}
    if lhs.returnBlock != rhs.returnBlock {return false}
    if lhs.returnReceipt != rhs.returnReceipt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_get_blocks_by_id_response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_blocks_by_id_response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_items"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.blockItems) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockItems.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.blockItems, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_blocks_by_id_response, rhs: Koinos_Rpc_BlockStore_get_blocks_by_id_response) -> Bool {
    if lhs.blockItems != rhs.blockItems {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_get_blocks_by_height_request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_blocks_by_height_request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "head_block_id"),
    2: .standard(proto: "ancestor_start_height"),
    3: .standard(proto: "num_blocks"),
    4: .standard(proto: "return_block"),
    5: .standard(proto: "return_receipt"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.headBlockID) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.ancestorStartHeight) }()
      case 3: try { try decoder.decodeSingularUInt32Field(value: &self.numBlocks) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.returnBlock) }()
      case 5: try { try decoder.decodeSingularBoolField(value: &self.returnReceipt) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.headBlockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.headBlockID, fieldNumber: 1)
    }
    if self.ancestorStartHeight != 0 {
      try visitor.visitSingularUInt64Field(value: self.ancestorStartHeight, fieldNumber: 2)
    }
    if self.numBlocks != 0 {
      try visitor.visitSingularUInt32Field(value: self.numBlocks, fieldNumber: 3)
    }
    if self.returnBlock != false {
      try visitor.visitSingularBoolField(value: self.returnBlock, fieldNumber: 4)
    }
    if self.returnReceipt != false {
      try visitor.visitSingularBoolField(value: self.returnReceipt, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_blocks_by_height_request, rhs: Koinos_Rpc_BlockStore_get_blocks_by_height_request) -> Bool {
    if lhs.headBlockID != rhs.headBlockID {return false}
    if lhs.ancestorStartHeight != rhs.ancestorStartHeight {return false}
    if lhs.numBlocks != rhs.numBlocks {return false}
    if lhs.returnBlock != rhs.returnBlock {return false}
    if lhs.returnReceipt != rhs.returnReceipt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_get_blocks_by_height_response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_blocks_by_height_response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_items"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.blockItems) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockItems.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.blockItems, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_blocks_by_height_response, rhs: Koinos_Rpc_BlockStore_get_blocks_by_height_response) -> Bool {
    if lhs.blockItems != rhs.blockItems {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_add_block_request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".add_block_request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_to_add"),
    2: .standard(proto: "receipt_to_add"),
  ]

  fileprivate class _StorageClass {
    var _blockToAdd: Koinos_Protocol_block? = nil
    var _receiptToAdd: Koinos_Protocol_block_receipt? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _blockToAdd = source._blockToAdd
      _receiptToAdd = source._receiptToAdd
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularMessageField(value: &_storage._blockToAdd) }()
        case 2: try { try decoder.decodeSingularMessageField(value: &_storage._receiptToAdd) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      try { if let v = _storage._blockToAdd {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      } }()
      try { if let v = _storage._receiptToAdd {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_add_block_request, rhs: Koinos_Rpc_BlockStore_add_block_request) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._blockToAdd != rhs_storage._blockToAdd {return false}
        if _storage._receiptToAdd != rhs_storage._receiptToAdd {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_add_block_response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".add_block_response"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_add_block_response, rhs: Koinos_Rpc_BlockStore_add_block_response) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_get_highest_block_request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_highest_block_request"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_highest_block_request, rhs: Koinos_Rpc_BlockStore_get_highest_block_request) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_get_highest_block_response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".get_highest_block_response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "topology"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._topology) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._topology {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_get_highest_block_response, rhs: Koinos_Rpc_BlockStore_get_highest_block_response) -> Bool {
    if lhs._topology != rhs._topology {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_block_store_request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".block_store_request"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "reserved"),
    2: .standard(proto: "get_blocks_by_id"),
    3: .standard(proto: "get_blocks_by_height"),
    4: .standard(proto: "add_block"),
    5: .standard(proto: "get_highest_block"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Koinos_Rpc_reserved_rpc?
        var hadOneofValue = false
        if let current = self.request {
          hadOneofValue = true
          if case .reserved(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.request = .reserved(v)
        }
      }()
      case 2: try {
        var v: Koinos_Rpc_BlockStore_get_blocks_by_id_request?
        var hadOneofValue = false
        if let current = self.request {
          hadOneofValue = true
          if case .getBlocksByID(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.request = .getBlocksByID(v)
        }
      }()
      case 3: try {
        var v: Koinos_Rpc_BlockStore_get_blocks_by_height_request?
        var hadOneofValue = false
        if let current = self.request {
          hadOneofValue = true
          if case .getBlocksByHeight(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.request = .getBlocksByHeight(v)
        }
      }()
      case 4: try {
        var v: Koinos_Rpc_BlockStore_add_block_request?
        var hadOneofValue = false
        if let current = self.request {
          hadOneofValue = true
          if case .addBlock(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.request = .addBlock(v)
        }
      }()
      case 5: try {
        var v: Koinos_Rpc_BlockStore_get_highest_block_request?
        var hadOneofValue = false
        if let current = self.request {
          hadOneofValue = true
          if case .getHighestBlock(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.request = .getHighestBlock(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.request {
    case .reserved?: try {
      guard case .reserved(let v)? = self.request else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .getBlocksByID?: try {
      guard case .getBlocksByID(let v)? = self.request else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .getBlocksByHeight?: try {
      guard case .getBlocksByHeight(let v)? = self.request else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .addBlock?: try {
      guard case .addBlock(let v)? = self.request else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .getHighestBlock?: try {
      guard case .getHighestBlock(let v)? = self.request else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_block_store_request, rhs: Koinos_Rpc_BlockStore_block_store_request) -> Bool {
    if lhs.request != rhs.request {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_Rpc_BlockStore_block_store_response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".block_store_response"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "reserved"),
    2: .same(proto: "error"),
    3: .standard(proto: "get_blocks_by_id"),
    4: .standard(proto: "get_blocks_by_height"),
    5: .standard(proto: "add_block"),
    6: .standard(proto: "get_highest_block"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try {
        var v: Koinos_Rpc_reserved_rpc?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .reserved(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .reserved(v)
        }
      }()
      case 2: try {
        var v: Koinos_Rpc_error_response?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .error(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .error(v)
        }
      }()
      case 3: try {
        var v: Koinos_Rpc_BlockStore_get_blocks_by_id_response?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .getBlocksByID(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .getBlocksByID(v)
        }
      }()
      case 4: try {
        var v: Koinos_Rpc_BlockStore_get_blocks_by_height_response?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .getBlocksByHeight(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .getBlocksByHeight(v)
        }
      }()
      case 5: try {
        var v: Koinos_Rpc_BlockStore_add_block_response?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .addBlock(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .addBlock(v)
        }
      }()
      case 6: try {
        var v: Koinos_Rpc_BlockStore_get_highest_block_response?
        var hadOneofValue = false
        if let current = self.response {
          hadOneofValue = true
          if case .getHighestBlock(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.response = .getHighestBlock(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    switch self.response {
    case .reserved?: try {
      guard case .reserved(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }()
    case .error?: try {
      guard case .error(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }()
    case .getBlocksByID?: try {
      guard case .getBlocksByID(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }()
    case .getBlocksByHeight?: try {
      guard case .getBlocksByHeight(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .addBlock?: try {
      guard case .addBlock(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case .getHighestBlock?: try {
      guard case .getHighestBlock(let v)? = self.response else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_Rpc_BlockStore_block_store_response, rhs: Koinos_Rpc_BlockStore_block_store_response) -> Bool {
    if lhs.response != rhs.response {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
