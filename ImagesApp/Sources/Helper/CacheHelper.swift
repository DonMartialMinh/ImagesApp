//
//  CacheHelper.swift
//  ImagesApp
//
//  Created by don.vo on 8/30/24.
//

import Foundation

final class CacheHelper<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()

    convenience init(cost: Int) {
        self.init()
        wrapped.totalCostLimit = cost
    }

    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    func removeAll() {
        wrapped.removeAllObjects()
    }
}

extension CacheHelper {
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}
