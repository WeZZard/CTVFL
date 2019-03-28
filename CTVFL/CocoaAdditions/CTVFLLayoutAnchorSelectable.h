//
//  CTVFLLayoutAnchorSelectable.h
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

@protocol CTVFLLayoutAnchor;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CTVFLLayoutAnchorSelectableSide) {
    CTVFLLayoutAnchorSelectableSideLhs,
    CTVFLLayoutAnchorSelectableSideRhs,
};


typedef NS_ENUM(NSInteger, CTVFLOrientation) {
    CTVFLOrientationHorizontal,
    CTVFLOrientationVertical,
};


typedef NS_ENUM(NSInteger, CTVFLLayoutAttribute) {
    CTVFLLayoutAttributeTop,
    CTVFLLayoutAttributeBottom,
    CTVFLLayoutAttributeLeft,
    CTVFLLayoutAttributeRight,
    CTVFLLayoutAttributeLeading,
    CTVFLLayoutAttributeTrailing,
    CTVFLLayoutAttributeWidth,
    CTVFLLayoutAttributeHeight,
    CTVFLLayoutAttributeCenterX,
    CTVFLLayoutAttributeCenterY,
    CTVFLLayoutAttributeFirstBaseline,
    CTVFLLayoutAttributeLastBaseline,
};

__attribute__((visibility("hidden")))
@protocol CTVFLLayoutAnchorSelectable
#if TARGET_OS_OSX
@property (nonatomic, weak, readonly, nullable) NSView * _ctvfl_ancestor;
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
@property (nonatomic, weak, readonly, nullable) UIView * _ctvfl_ancestor;
#endif

- (CTVFLLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLLayoutAnchorSelectableSide)side
                                                   forOrientation:(CTVFLOrientation)orientation
                                                      withOptions:(NSLayoutFormatOptions)options;

- (id<CTVFLLayoutAnchor>)_ctvfl_anchorForAttribute:(CTVFLLayoutAttribute)attribute;
@end

#if TARGET_OS_OSX
__attribute__((visibility("hidden")))
@interface NSView (CTVFLLayoutAnchorSelectable)<CTVFLLayoutAnchorSelectable>
@end

__attribute__((visibility("hidden")))
@interface NSLayoutGuide (CTVFLLayoutAnchorSelectable)<CTVFLLayoutAnchorSelectable>
@end
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
__attribute__((visibility("hidden")))
@interface UIView (CTVFLLayoutAnchorSelectable)<CTVFLLayoutAnchorSelectable>
@end

__attribute__((visibility("hidden")))
@interface UILayoutGuide (CTVFLLayoutAnchorSelectable)<CTVFLLayoutAnchorSelectable>
@end
#endif

NS_ASSUME_NONNULL_END
