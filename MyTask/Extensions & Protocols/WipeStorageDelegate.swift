//
//  WipeStorageDelegate.swift
//  MyTask
//
//  Created by Danil on 18.11.2024.
//

// MARK: - Multicast Delegate protocol

protocol WipeStorageDelegate: AnyObject {
    func storageWiped()
}

// MARK: - Multicast Delegate class

class WipeStorageMulticastDelegateClass<T> {
    private var delegates = [WeakWrapper]()
    
    func addDelegate(_ delegate: T) {
        delegates.append(WeakWrapper(value: delegate as AnyObject))
    }
    
    func removeDelegate(_ delegate: T) {
        delegates = delegates.filter { $0.value !== delegate as AnyObject }
    }
    
    func invoke(_ invocation: (T) -> Void) {
        for (index, delegate) in delegates.enumerated().reversed() {
            if let delegate = delegate.value as? T {
                invocation(delegate)
            } else {
                delegates.remove(at: index)
            }
        }
    }
    
    private class WeakWrapper {
        weak var value: AnyObject?
        init(value: AnyObject) {
            self.value = value
        }
    }
}
