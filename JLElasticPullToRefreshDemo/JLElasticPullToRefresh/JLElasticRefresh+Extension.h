//
//  JLElasticRefresh+Extension.h
//  Janlor
//
//  Created by Janlor on 2018/5/7.
//  Copyright © 2018 Janlor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizer.h>

@class JLElasticRefreshLoadingView;

@interface NSObject (JLElasticRefresh)

- (void)cyer_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)cyer_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end

@interface UIScrollView (JLElasticRefresh)

- (void)cyer_addRefreshWithActionHandler:(void(^)(void))actionHandler
                             loadingView:(JLElasticRefreshLoadingView *)loadingView;
- (void)cyer_removeRefresh;
- (void)cyer_setRefreshBackgroundColor:(UIColor *)color;
- (void)cyer_setRefreshFillColor:(UIColor *)color;
- (void)cyer_stopLoading;

@end

@interface UIView (JLElasticRefresh)

- (CGPoint)cyer_center:(BOOL)usePresentationLayerIfPossible;

@end

@interface UIPanGestureRecognizer (JLElasticRefresh)

- (void)cyer_resign;

@end

