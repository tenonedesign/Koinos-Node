//
//  Utils.swift
//  Koinos Node
//
//  Created by Peter Skinner on 10/14/22.
//

import Foundation
import SwiftUI

// for generic throwable errors e.g. throw "some error description"
// https://stackoverflow.com/a/40629365
extension String: Error {}
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
extension Data {
    public var toHexString: String {
        return self.map{ String(format: "%02x", $0) }.joined()
    }
    public init?(base64urlEncoded input: String, options: Data.Base64DecodingOptions = []) {
        var base64 = input
        base64 = base64.replacingOccurrences(of: "-", with: "+")
        base64 = base64.replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 = base64.appending("=")
        }
        self.init(base64Encoded: base64, options: options)
    }
    public func base64urlEncodedString(options: Data.Base64EncodingOptions = []) -> String {
        var result = self.base64EncodedString(options: options)
        result = result.replacingOccurrences(of: "+", with: "-")
        result = result.replacingOccurrences(of: "/", with: "_")
        result = result.replacingOccurrences(of: "=", with: "")
        return result
    }
}
extension String {
    var toDataFromHex: Data? {
        var data = Data(capacity: self.count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }

        guard data.count > 0 else { return nil }

        return data
    }
//    var binaryStringFromHex: String {
//        return binaryStringFromHex.map {
//            let binary = String($0, radix: 2)
//            return repeatElement("0", count: 8-binary.count) + binary
//        }.joined()
//    }
}
// only to support color conversion before macOS 12
extension NSColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
extension Color {
    init(compatNsColor: NSColor) {
        let color = compatNsColor.usingColorSpace(NSColorSpace.deviceRGB) ?? NSColor.black
        self.init(red: Double(color.rgba.red),
                  green: Double(color.rgba.green),
                  blue: Double(color.rgba.blue),
                  opacity: Double(color.rgba.alpha))
    }
}
