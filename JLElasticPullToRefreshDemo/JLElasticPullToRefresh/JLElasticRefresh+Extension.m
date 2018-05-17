//
//  JLElasticRefresh+Extension.m
//  Janlor
//
//  Created by Janlor on 2018/5/7.
//  Copyright © 2018 Janlor. All rights reserved.
//

#import "JLElasticRefresh+Extension.h"
#import <objc/runtime.h>
#import "JLElasticRefreshLoadingView.h"
#import "JLElasticRefreshView.h"

#pragma mark - NSObject

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray *cyer_observers;

@end

@implementation NSObject (JLElasticRefresh)

static char *cyer_associatedObserversKeys = "observers";

- (NSMutableArray *)cyer_observers {
    NSMutableArray *observers = objc_getAssociatedObject(self, cyer_associatedObserversKeys);
    if (!observers) {
        observers = [NSMutableArray array];
        self.cyer_observers = observers;
    }
    return observers;
}

- (void)setCyer_observers:(NSMutableArray *)cyer_observers {
    objc_setAssociatedObject(self, cyer_associatedObserversKeys, cyer_observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cyer_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSDictionary *observerInfo = @{keyPath: observer};
    if (![self.cyer_observers containsObject:observerInfo]) {
        [self.cyer_observers addObject:observerInfo];
        [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)cyer_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSDictionary *observerInfo = @{keyPath: observer};
    if ([self.cyer_observers containsObject:observerInfo]) {
        [self.cyer_observers removeObject:observerInfo];
        [self removeObserver:observer forKeyPath:keyPath];
    }
}

@end

#pragma mark - UIScrollView

@interface UIScrollView ()

@property (nonatomic, strong) JLElasticRefreshView *refreshView;

@end

@implementation UIScrollView (JLElasticRefresh)

static char *cyer_associatedRefreshViewKeys = "RefreshView";

- (UIView *)refreshView {
    return objc_getAssociatedObject(self, cyer_associatedRefreshViewKeys);
}

- (void)setRefreshView:(UIView *)refreshView {
    objc_setAssociatedObject(self, cyer_associatedRefreshViewKeys, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cyer_addRefreshWithActionHandler:(void(^)(void))actionHandler loadingView:(JLElasticRefreshLoadingView *)loadingView {
    self.multipleTouchEnabled = NO;
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    
    JLElasticRefreshView *refreshView = [[JLElasticRefreshView alloc] init];
    self.refreshView = refreshView;
    refreshView.actionHandler = actionHandler;
    refreshView.loadingView = loadingView;
    [self addSubview:refreshView];
    refreshView.observing = YES;
}

- (void)cyer_removeRefresh {
    [self.refreshView disassociateDisplayLink];
    self.refreshView.observing = NO;
    [self.refreshView removeFromSuperview];
}

- (void)cyer_setRefreshBackgroundColor:(UIColor *)color {
    self.refreshView.backgroundColor = color;
}

- (void)cyer_setRefreshFillColor:(UIColor *)color {
    self.refreshView.fillColor = color;
}

- (void)cyer_stopLoading {
    [self.refreshView stopLoading];
}

@end

#pragma mark - UIView

@implementation UIView (JLElasticRefresh)

- (CGPoint)cyer_center:(BOOL)usePresentationLayerIfPossible {
    CALayer *presentationLayer = self.layer.presentationLayer;
    if (usePresentationLayerIfPossible && presentationLayer) {
        return presentationLayer.position;
    }
    return self.center;
}

@end

#pragma mark - UIPanGestureRecognizer

@implementation UIPanGestureRecognizer (JLElasticRefresh)

- (void)cyer_resign {
    self.enabled = NO;
    self.enabled = YES;
}

@end

