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

#import <CTVFL/CTVFLNSLayoutConstrained.h>

NS_ASSUME_NONNULL_BEGIN

/** Name the type explicitly, eliminates Any -> Objective-C convertion
 consumptions.
 */
__attribute__((visibility("hidden")))
@interface NSLayoutConstraint (CTVFL)
@property (nonatomic, strong, readonly, nullable) id<CTVFLNSLayoutConstrained> _ctvfl_firstItem NS_REFINED_FOR_SWIFT;
@property (nonatomic, strong, readonly, nullable) id<CTVFLNSLayoutConstrained> _ctvfl_secondItem NS_REFINED_FOR_SWIFT;

#if TARGET_OS_OSX
+ (instancetype)_ctvfl_constraintWithItem:(id<CTVFLNSLayoutConstrained>)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(nullable id<CTVFLNSLayoutConstrained>)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c NS_REFINED_FOR_SWIFT;
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
+ (instancetype)_ctvfl_constraintWithItem:(id<CTVFLNSLayoutConstrained>)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(nullable id<CTVFLNSLayoutConstrained>)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c NS_REFINED_FOR_SWIFT;
#endif
@end
NS_ASSUME_NONNULL_END
