//
//  Notification.swift
//  DropEvent
//
//  Created by Jeremy Noonan on 5/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

public class Notification<T> {
    
    public typealias NotificationHandler = T -> ()
    
    private var notificationHandlers = [Invocable]()
    
    public func raise(data: T) {
        for handler in self.notificationHandlers {
            handler.invoke(data)
        }
    }
    
    public func addHandler<U: AnyObject>(target: U, handler: (U) -> NotificationHandler) -> Disposable {
        let wrapper = NotificationHandlerWrapper(target: target, handler: handler, event: self)
        notificationHandlers.append(wrapper)
        return wrapper
    }
}

private protocol Invocable: class {
    func invoke(data: Any)
}

private class NotificationHandlerWrapper<T: AnyObject, U> : Invocable, Disposable {
    weak var target: T?
    let handler: T -> U -> ()
    let event: Notification<U>
    
    init(target: T?, handler: T -> U -> (), event: Notification<U>) {
        self.target = target
        self.handler = handler
        self.event = event;
    }
    
    func invoke(data: Any) -> () {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    func dispose() {
        event.notificationHandlers = event.notificationHandlers.filter { $0 !== self }
    }
}

public protocol Disposable {
    func dispose()
}