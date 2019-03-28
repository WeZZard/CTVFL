//
//  CTVFLNSLayoutConstrained.m
//  CTVFL
//
//  Created on 2019/3/28.
//

#import "CTVFLNSLayoutConstrained.h"

static NSLayoutAttribute _LayoutGuideGetAttribute(CTVFLNSLayoutConstrainedSide, CTVFLNSLayoutConstrainedOrientation, NSLayoutFormatOptions);
static NSLayoutAttribute _ViewGetAttribute(CTVFLNSLayoutConstrainedSide, CTVFLNSLayoutConstrainedOrientation, NSLayoutFormatOptions);

#if TARGET_OS_OSX
@implementation NSView (CTVFLNSLayoutConstrained)
- (NSView *)_ctvfl_ancestor
{
    return [self superview];
}

- (NSLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLNSLayoutConstrainedSide)side
                                                forOrientation:(CTVFLNSLayoutConstrainedOrientation)orientation
                                                   withOptions:(NSLayoutFormatOptions)options
{
    return _ViewGetAttribute(side, orientation, options);
}
@end

@implementation NSLayoutGuide (CTVFLNSLayoutConstrained)
- (NSView *)_ctvfl_ancestor
{
    return [self owningView];
}

- (NSLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLNSLayoutConstrainedSide)side
                                                forOrientation:(CTVFLNSLayoutConstrainedOrientation)orientation
                                                   withOptions:(NSLayoutFormatOptions)options
{
    return _LayoutGuideGetAttribute(side, orientation, options);
}
@end
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
@implementation UIView (CTVFLNSLayoutConstrained)
- (UIView *)_ctvfl_ancestor
{
    return [self superview];
}

- (NSLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLNSLayoutConstrainedSide)side
                                                forOrientation:(CTVFLNSLayoutConstrainedOrientation)orientation
                                                   withOptions:(NSLayoutFormatOptions)options
{
    return _ViewGetAttribute(side, orientation, options);
}
@end

@implementation UILayoutGuide (CTVFLNSLayoutConstrained)
- (UIView *)_ctvfl_ancestor
{
    return [self owningView];
}

- (NSLayoutAttribute)_ctvfl_attributeForBeingConstrainedAtSide:(CTVFLNSLayoutConstrainedSide)side
                                                forOrientation:(CTVFLNSLayoutConstrainedOrientation)orientation
                                                   withOptions:(NSLayoutFormatOptions)options
{
    return _LayoutGuideGetAttribute(side, orientation, options);
}
@end
#endif

static NSLayoutAttribute _LayoutGuideGetAttribute(CTVFLNSLayoutConstrainedSide side, CTVFLNSLayoutConstrainedOrientation orientation, NSLayoutFormatOptions options) {
    switch (orientation) {
        case CTVFLNSLayoutConstrainedOrientationVertical:
            switch (side) {
                case CTVFLNSLayoutConstrainedSideLhs:
                    if (@available(iOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return NSLayoutAttributeFirstBaseline;
                        }
                    }
                    return NSLayoutAttributeTop;
                case CTVFLNSLayoutConstrainedSideRhs:
                    if (@available(iOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return NSLayoutAttributeLastBaseline;
                        }
                    }
                    return NSLayoutAttributeBottom;
            }
        case CTVFLNSLayoutConstrainedOrientationHorizontal:
            switch (side) {
                case CTVFLNSLayoutConstrainedSideLhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return NSLayoutAttributeLeft;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return NSLayoutAttributeRight;
                        }
                    }
                    return NSLayoutAttributeLeading;
                case CTVFLNSLayoutConstrainedSideRhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return NSLayoutAttributeRight;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return NSLayoutAttributeLeft;
                        }
                    }
                    return NSLayoutAttributeTrailing;
            }
    }
}

static NSLayoutAttribute _ViewGetAttribute(CTVFLNSLayoutConstrainedSide side, CTVFLNSLayoutConstrainedOrientation orientation, NSLayoutFormatOptions options) {
    switch (orientation) {
        case CTVFLNSLayoutConstrainedOrientationVertical:
            switch (side) {
                case CTVFLNSLayoutConstrainedSideLhs:
                    if (@available(iOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return NSLayoutAttributeLastBaseline;
                        }
                    }
                    return NSLayoutAttributeBottom;
                case CTVFLNSLayoutConstrainedSideRhs:
                    if (@available(iOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return NSLayoutAttributeFirstBaseline;
                        }
                    }
                    return NSLayoutAttributeTop;
            }
        case CTVFLNSLayoutConstrainedOrientationHorizontal:
            switch (side) {
                case CTVFLNSLayoutConstrainedSideLhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return NSLayoutAttributeRight;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return NSLayoutAttributeLeft;
                        }
                    }
                    return NSLayoutAttributeTrailing;
                case CTVFLNSLayoutConstrainedSideRhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return NSLayoutAttributeLeft;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return NSLayoutAttributeRight;
                        }
                    }
                    return NSLayoutAttributeLeading;
            }
    }
}
