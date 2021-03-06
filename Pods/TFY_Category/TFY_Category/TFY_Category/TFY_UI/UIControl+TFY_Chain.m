//
//  UIControl+TFY_Chain.m
//  TFY_Category
//
//  Created by 田风有 on 2019/12/29.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "UIControl+TFY_Chain.h"
#import <objc/runtime.h>

@implementation UIControl (TFY_Chain)

- (NSMutableDictionary *)actions {
    return objc_getAssociatedObject(self, @"chance_UIControl_Events_actions");
}
- (void)setActions:(NSMutableDictionary *)actions {
    objc_setAssociatedObject(self, @"chance_UIControl_Events_actions", actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tfy_addControlEvents:(UIControlEvents)controlEvents withAction:(void(^)(id sender))action {
    [self tfy_addControlEvents:controlEvents withAction:action forKey:nil];
}
- (void)tfy_removeControlEvents:(UIControlEvents)controlEvents {
    [self.actions removeObjectForKey:@(controlEvents)];
}

- (void)tfy_addControlEvents:(UIControlEvents)controlEvents withAction:(void(^)(id sender))action forKey:(NSString *__nullable)key {
    if (!self.actions) {
        self.actions = [NSMutableDictionary dictionary];
    }
    NSMutableDictionary *dict = [self.actions objectForKey:@(controlEvents)] ?: [NSMutableDictionary dictionary];
    
    if (!key || [key isEqualToString:@""]) {
        key = [NSString stringWithFormat:@"%ld", (long)dict.count];
    }
    [dict setObject:action forKey:key];
    [self.actions setObject:dict forKey:@(controlEvents)];
    
    SEL selector = [self functionName:controlEvents];
    [self addTarget:self action:selector forControlEvents:controlEvents];
}
- (void)tfy_removeControlEvents:(UIControlEvents)controlEvents forKey:(NSString *)key {
    NSMutableDictionary *dict = [self.actions objectForKey:@(controlEvents)];
    if (key && ![key isEqualToString:@""]) {
        [dict removeObjectForKey:key];
    }
}

- (void)tfy_addAction:(void (^)(id sender))action {
    [self tfy_addControlEvents:UIControlEventTouchUpInside withAction:action forKey:@"__addAction:"];
}
- (void)tfy_removeAction {
    [self tfy_removeControlEvents:UIControlEventTouchUpInside forKey:@"__addAction:"];
}

- (void)tfy_removeAllActions {
    [self.actions removeAllObjects];
}

#pragma mark - GET SEL
- (SEL)functionName:(UIControlEvents)controlEvents {
    switch (controlEvents) {
        case UIControlEventTouchDown: return @selector(controlEventTouchDownAction);
        case UIControlEventTouchDownRepeat: return @selector(controlEventTouchDownRepeatAction);
        case UIControlEventTouchDragInside: return @selector(controlEventTouchDragInsideAction);
        case UIControlEventTouchDragOutside: return @selector(controlEventTouchDragOutsideAction);
        case UIControlEventTouchDragEnter: return @selector(controlEventTouchDragEnterAction);
        case UIControlEventTouchDragExit: return @selector(controlEventTouchDragExitAction);
        case UIControlEventTouchUpInside: return @selector(controlEventTouchUpInsideAction);
        case UIControlEventTouchUpOutside: return @selector(controlEventTouchUpOutsideAction);
        case UIControlEventTouchCancel: return @selector(controlEventTouchCancelAction);
        case UIControlEventValueChanged: return @selector(controlEventValueChangedAction);
        case UIControlEventEditingDidBegin: return @selector(controlEventEditingDidBeginAction);
        case UIControlEventEditingChanged: return @selector(controlEventEditingChangedAction);
        case UIControlEventEditingDidEnd: return @selector(controlEventEditingDidEndAction);
        case UIControlEventEditingDidEndOnExit: return @selector(controlEventEditingDidEndOnExitAction);
        case UIControlEventAllTouchEvents: return @selector(controlEventAllTouchEventsAction);
        case UIControlEventAllEditingEvents: return @selector(controlEventAllEditingEventsAction);
        case UIControlEventApplicationReserved: return @selector(controlEventApplicationReservedAction);
        case UIControlEventSystemReserved: return @selector(controlEventSystemReservedAction);
        case UIControlEventAllEvents: return @selector(controlEventAllEventsAction);
        default: return NULL;
    }
}

#pragma mark - Events
- (void)controlEventTouchDownAction {[self execFunctionWithControlEvents:UIControlEventTouchDown];}
- (void)controlEventTouchDownRepeatAction {[self execFunctionWithControlEvents:UIControlEventTouchDownRepeat];}
- (void)controlEventTouchDragInsideAction {[self execFunctionWithControlEvents:UIControlEventTouchDragInside];}
- (void)controlEventTouchDragOutsideAction {[self execFunctionWithControlEvents:UIControlEventTouchDragOutside];}
- (void)controlEventTouchDragEnterAction {[self execFunctionWithControlEvents:UIControlEventTouchDragEnter];}
- (void)controlEventTouchDragExitAction {[self execFunctionWithControlEvents:UIControlEventTouchDragExit];}
- (void)controlEventTouchUpInsideAction {[self execFunctionWithControlEvents:UIControlEventTouchUpInside];}
- (void)controlEventTouchUpOutsideAction {[self execFunctionWithControlEvents:UIControlEventTouchUpOutside];}
- (void)controlEventTouchCancelAction {[self execFunctionWithControlEvents:UIControlEventTouchCancel];}
- (void)controlEventValueChangedAction {[self execFunctionWithControlEvents:UIControlEventValueChanged];}
- (void)controlEventEditingDidBeginAction {[self execFunctionWithControlEvents:UIControlEventEditingDidBegin];}
- (void)controlEventEditingChangedAction {[self execFunctionWithControlEvents:UIControlEventEditingChanged];}
- (void)controlEventEditingDidEndAction {[self execFunctionWithControlEvents:UIControlEventEditingDidEnd];}
- (void)controlEventEditingDidEndOnExitAction {[self execFunctionWithControlEvents:UIControlEventEditingDidEndOnExit];}
- (void)controlEventAllTouchEventsAction {[self execFunctionWithControlEvents:UIControlEventAllTouchEvents];}
- (void)controlEventAllEditingEventsAction {[self execFunctionWithControlEvents:UIControlEventAllEditingEvents];}
- (void)controlEventApplicationReservedAction {[self execFunctionWithControlEvents:UIControlEventApplicationReserved];}
- (void)controlEventSystemReservedAction {[self execFunctionWithControlEvents:UIControlEventSystemReserved];}
- (void)controlEventAllEventsAction {[self execFunctionWithControlEvents:UIControlEventAllEvents];}

#pragma mark - Execute
- (void)execFunctionWithControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *dict = [self.actions objectForKey:@(controlEvents)];
    for (void(^block)(id sender) in [dict allValues]) {
        if (block) {
            block(self);
        }
    }
}
@end
