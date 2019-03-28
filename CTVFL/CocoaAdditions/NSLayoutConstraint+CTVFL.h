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

#import <CTVFL/CTVFLLayoutAnchorSelectable.h>

NS_ASSUME_NONNULL_BEGIN

/** Name the type explicitly, eliminates Any -> Objective-C convertion
 consumptions.
 */
__attribute__((visibility("hidden")))
@interface NSLayoutConstraint (CTVFL)
@property (nonatomic, strong, readonly, nullable) id<CTVFLLayoutAnchorSelectable> _ctvfl_firstItem NS_REFINED_FOR_SWIFT;
@property (nonatomic, strong, readonly, nullable) id<CTVFLLayoutAnchorSelectable> _ctvfl_secondItem NS_REFINED_FOR_SWIFT;
@end
NS_ASSUME_NONNULL_END
