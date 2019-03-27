//
//  NSLayoutConstraint+CTVFL.h
//  CTVFL
//
//  Created by Yu-Long Li on 2019/3/27.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (CTVFL)
#if TARGET_OS_OSX
+ (instancetype)_ctvfl_constraintWithItem:(NSView *)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(nullable NSView *)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c NS_REFINED_FOR_SWIFT;
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
+ (instancetype)_ctvfl_constraintWithItem:(UIView *)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(nullable UIView *)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c NS_REFINED_FOR_SWIFT;
#endif
@end

NS_ASSUME_NONNULL_END
