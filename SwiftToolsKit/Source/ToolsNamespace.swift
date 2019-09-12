//
//  ToolsNamespace.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var st: WrapperType { get }
    static var st: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var st: NamespaceWrapper<Self> {
        get {
            return NamespaceWrapper(value: self)
        }
    }
    static var st: NamespaceWrapper<Self>.Type {
        get {
            return NamespaceWrapper.self
        }
    }
}

public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get set }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public var wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}
