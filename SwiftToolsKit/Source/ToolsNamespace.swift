//
//  ToolsNamespace.swift
//  SwiftToolsKit
//
//  Created by DePeng on 2019/7/21.
//  Copyright © 2019 DePeng. All rights reserved.
//

import Foundation

public protocol STKTypeWrapperProtocol {
    associatedtype STKWrappedType
    var stkWrappedValue: STKWrappedType { get set }
    init(value: STKWrappedType)
}

public struct STKNamespaceWrapper<T>: STKTypeWrapperProtocol {
    public var stkWrappedValue: T
    public init(value: T) {
        self.stkWrappedValue = value
    }
}

public protocol STKNamespaceWrappable {
    associatedtype STKWrapperType
    var stk: STKWrapperType { get }
    static var stk: STKWrapperType.Type { get }
}

public extension STKNamespaceWrappable {
    var stk: STKNamespaceWrapper<Self> {
        get {
            return STKNamespaceWrapper(value: self)
        }
    }
    static var stk: STKNamespaceWrapper<Self>.Type {
        get {
            return STKNamespaceWrapper.self
        }
    }
}
