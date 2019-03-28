//
//  CTVFLNSLayoutConstrained.h
//  CTVFL
//
//  Created on 2019/3/28.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#endif

typedef NS_ENUM(NSInteger, CTVFLNSLayoutConstrainedSide) {
    CTVFLNSLayoutConstrainedSideLhs,
    CTVFLNSLayoutConstrainedSideRhs,
};


typedef NS_ENUM(NSInteger, CTVFLNSLayoutConstrainedOrientation) {
    CTVFLNSLayoutConstrainedOrientationHorizontal,
    CTVFLNSLayoutConstrainedOrientationVertical,
};

@protocol CTVFLNSLayoutConstrained
#if TARGET_OS_OSX
@property (nonatomic, weak, readonly, nullable) NSView * _ctvfl_ancestor;
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
@property (nonatomic, weak, readonly, nullable) UIView * _ctvfl_ancestor;
#endif

- (NSLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLNSLayoutConstrainedSide)side
                                                forOrientation:(CTVFLNSLayoutConstrainedOrientation)orientation
                                                   withOptions:(NSLayoutFormatOptions)options;
@end

#if TARGET_OS_OSX
__attribute__((visibility("hidden")))
@interface NSView (CTVFLNSLayoutConstrained)<CTVFLNSLayoutConstrained>
@end

__attribute__((visibility("hidden")))
@interface NSLayoutGuide (CTVFLNSLayoutConstrained)<CTVFLNSLayoutConstrained>
@end
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
__attribute__((visibility("hidden")))
@interface UIView (CTVFLNSLayoutConstrained)<CTVFLNSLayoutConstrained>
@end

__attribute__((visibility("hidden")))
@interface UILayoutGuide (CTVFLNSLayoutConstrained)<CTVFLNSLayoutConstrained>
@end
#endif
