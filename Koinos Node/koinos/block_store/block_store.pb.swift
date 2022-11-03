// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: koinos/block_store/block_store.proto
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

struct Koinos_BlockStore_block_item {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockID: Data {
    get {return _storage._blockID}
    set {_uniqueStorage()._blockID = newValue}
  }

  var blockHeight: UInt64 {
    get {return _storage._blockHeight}
    set {_uniqueStorage()._blockHeight = newValue}
  }

  ///optional
  var block: Koinos_Protocol_block {
    get {return _storage._block ?? Koinos_Protocol_block()}
    set {_uniqueStorage()._block = newValue}
  }
  /// Returns true if `block` has been explicitly set.
  var hasBlock: Bool {return _storage._block != nil}
  /// Clears the value of `block`. Subsequent reads from it will return its default value.
  mutating func clearBlock() {_uniqueStorage()._block = nil}

  ///optional
  var receipt: Koinos_Protocol_block_receipt {
    get {return _storage._receipt ?? Koinos_Protocol_block_receipt()}
    set {_uniqueStorage()._receipt = newValue}
  }
  /// Returns true if `receipt` has been explicitly set.
  var hasReceipt: Bool {return _storage._receipt != nil}
  /// Clears the value of `receipt`. Subsequent reads from it will return its default value.
  mutating func clearReceipt() {_uniqueStorage()._receipt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Koinos_BlockStore_block_record {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockID: Data {
    get {return _storage._blockID}
    set {_uniqueStorage()._blockID = newValue}
  }

  var blockHeight: UInt64 {
    get {return _storage._blockHeight}
    set {_uniqueStorage()._blockHeight = newValue}
  }

  var block: Koinos_Protocol_block {
    get {return _storage._block ?? Koinos_Protocol_block()}
    set {_uniqueStorage()._block = newValue}
  }
  /// Returns true if `block` has been explicitly set.
  var hasBlock: Bool {return _storage._block != nil}
  /// Clears the value of `block`. Subsequent reads from it will return its default value.
  mutating func clearBlock() {_uniqueStorage()._block = nil}

  ///optional
  var receipt: Koinos_Protocol_block_receipt {
    get {return _storage._receipt ?? Koinos_Protocol_block_receipt()}
    set {_uniqueStorage()._receipt = newValue}
  }
  /// Returns true if `receipt` has been explicitly set.
  var hasReceipt: Bool {return _storage._receipt != nil}
  /// Clears the value of `receipt`. Subsequent reads from it will return its default value.
  mutating func clearReceipt() {_uniqueStorage()._receipt = nil}

  var previousBlockIds: [Data] {
    get {return _storage._previousBlockIds}
    set {_uniqueStorage()._previousBlockIds = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Koinos_BlockStore_block_item: @unchecked Sendable {}
extension Koinos_BlockStore_block_record: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "koinos.block_store"

extension Koinos_BlockStore_block_item: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".block_item"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .standard(proto: "block_height"),
    3: .same(proto: "block"),
    4: .same(proto: "receipt"),
  ]

  fileprivate class _StorageClass {
    var _blockID: Data = Data()
    var _blockHeight: UInt64 = 0
    var _block: Koinos_Protocol_block? = nil
    var _receipt: Koinos_Protocol_block_receipt? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _blockID = source._blockID
      _blockHeight = source._blockHeight
      _block = source._block
      _receipt = source._receipt
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
        case 1: try { try decoder.decodeSingularBytesField(value: &_storage._blockID) }()
        case 2: try { try decoder.decodeSingularUInt64Field(value: &_storage._blockHeight) }()
        case 3: try { try decoder.decodeSingularMessageField(value: &_storage._block) }()
        case 4: try { try decoder.decodeSingularMessageField(value: &_storage._receipt) }()
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
      if !_storage._blockID.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._blockID, fieldNumber: 1)
      }
      if _storage._blockHeight != 0 {
        try visitor.visitSingularUInt64Field(value: _storage._blockHeight, fieldNumber: 2)
      }
      try { if let v = _storage._block {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      } }()
      try { if let v = _storage._receipt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_BlockStore_block_item, rhs: Koinos_BlockStore_block_item) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._blockID != rhs_storage._blockID {return false}
        if _storage._blockHeight != rhs_storage._blockHeight {return false}
        if _storage._block != rhs_storage._block {return false}
        if _storage._receipt != rhs_storage._receipt {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Koinos_BlockStore_block_record: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".block_record"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .standard(proto: "block_height"),
    3: .same(proto: "block"),
    4: .same(proto: "receipt"),
    5: .standard(proto: "previous_block_ids"),
  ]

  fileprivate class _StorageClass {
    var _blockID: Data = Data()
    var _blockHeight: UInt64 = 0
    var _block: Koinos_Protocol_block? = nil
    var _receipt: Koinos_Protocol_block_receipt? = nil
    var _previousBlockIds: [Data] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _blockID = source._blockID
      _blockHeight = source._blockHeight
      _block = source._block
      _receipt = source._receipt
      _previousBlockIds = source._previousBlockIds
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
        case 1: try { try decoder.decodeSingularBytesField(value: &_storage._blockID) }()
        case 2: try { try decoder.decodeSingularUInt64Field(value: &_storage._blockHeight) }()
        case 3: try { try decoder.decodeSingularMessageField(value: &_storage._block) }()
        case 4: try { try decoder.decodeSingularMessageField(value: &_storage._receipt) }()
        case 5: try { try decoder.decodeRepeatedBytesField(value: &_storage._previousBlockIds) }()
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
      if !_storage._blockID.isEmpty {
        try visitor.visitSingularBytesField(value: _storage._blockID, fieldNumber: 1)
      }
      if _storage._blockHeight != 0 {
        try visitor.visitSingularUInt64Field(value: _storage._blockHeight, fieldNumber: 2)
      }
      try { if let v = _storage._block {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      } }()
      try { if let v = _storage._receipt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
      } }()
      if !_storage._previousBlockIds.isEmpty {
        try visitor.visitRepeatedBytesField(value: _storage._previousBlockIds, fieldNumber: 5)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Koinos_BlockStore_block_record, rhs: Koinos_BlockStore_block_record) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._blockID != rhs_storage._blockID {return false}
        if _storage._blockHeight != rhs_storage._blockHeight {return false}
        if _storage._block != rhs_storage._block {return false}
        if _storage._receipt != rhs_storage._receipt {return false}
        if _storage._previousBlockIds != rhs_storage._previousBlockIds {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
