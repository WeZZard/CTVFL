//
//  CTVFLLayoutAnchorSelectable.m
//  CTVFL
//
//  Created on 2019/3/28.
//

#import "CTVFLLayoutAnchorSelectable.h"
#import "CTVFLLayoutAnchor.h"

static CTVFLLayoutAttribute _LayoutGuideGetAttribute(CTVFLSyntaxEvaluationSite, CTVFLOrientation, NSLayoutFormatOptions);
static CTVFLLayoutAttribute _ViewGetAttribute(CTVFLSyntaxEvaluationSite, CTVFLOrientation, NSLayoutFormatOptions);

static id<CTVFLLayoutAnchor> _GetLayoutAnchor(id, CTVFLLayoutAttribute);

#if TARGET_OS_OSX
@implementation NSView (CTVFLLayoutAnchorSelectable)
- (NSView *)_ctvfl_ancestor
{
    return [self superview];
}

- (CTVFLLayoutAttribute)_ctvfl_attributeForBeingEvaluatedAtSite:(CTVFLSyntaxEvaluationSite)site
                                                   forOrientation:(CTVFLOrientation)orientation
                                                      withOptions:(NSLayoutFormatOptions)options
{
    return _ViewGetAttribute(site, orientation, options);
}

- (id<CTVFLLayoutAnchor>)_ctvfl_anchorForAttribute:(CTVFLLayoutAttribute)attribute
{
    return _GetLayoutAnchor(self, attribute);
}
@end

@implementation NSLayoutGuide (CTVFLLayoutAnchorSelectable)
- (NSView *)_ctvfl_ancestor
{
    return [self owningView];
}

- (CTVFLLayoutAttribute)_ctvfl_attributeForBeingEvaluatedAtSite:(CTVFLSyntaxEvaluationSite)site
                                                   forOrientation:(CTVFLOrientation)orientation
                                                      withOptions:(NSLayoutFormatOptions)options
{
    return _LayoutGuideGetAttribute(site, orientation, options);
}

- (id<CTVFLLayoutAnchor>)_ctvfl_anchorForAttribute:(CTVFLLayoutAttribute)attribute
{
    return _GetLayoutAnchor(self, attribute);
}
@end
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
@implementation UIView (CTVFLLayoutAnchorSelectable)
- (UIView *)_ctvfl_ancestor
{
    return [self superview];
}

- (CTVFLLayoutAttribute)_ctvfl_attributeForBeingEvaluatedAtSite:(CTVFLSyntaxEvaluationSite)site
                                                   forOrientation:(CTVFLOrientation)orientation
                                                      withOptions:(NSLayoutFormatOptions)options
{
    return _ViewGetAttribute(site, orientation, options);
}

- (id<CTVFLLayoutAnchor>)_ctvfl_anchorForAttribute:(CTVFLLayoutAttribute)attribute
{
    return _GetLayoutAnchor(self, attribute);
}
@end

@implementation UILayoutGuide (CTVFLLayoutAnchorSelectable)
- (UIView *)_ctvfl_ancestor
{
    return [self owningView];
}

- (CTVFLLayoutAttribute)_ctvfl_attributeForBeingEvaluatedAtSite:(CTVFLSyntaxEvaluationSite)site
                                                   forOrientation:(CTVFLOrientation)orientation
                                                      withOptions:(NSLayoutFormatOptions)options
{
    return _LayoutGuideGetAttribute(site, orientation, options);
}

- (id<CTVFLLayoutAnchor>)_ctvfl_anchorForAttribute:(CTVFLLayoutAttribute)attribute
{
    return _GetLayoutAnchor(self, attribute);
}
@end
#endif

static CTVFLLayoutAttribute _LayoutGuideGetAttribute(CTVFLSyntaxEvaluationSite site, CTVFLOrientation orientation, NSLayoutFormatOptions options) {
    switch (orientation) {
        case CTVFLOrientationVertical:
            switch (site) {
                case CTVFLSyntaxEvaluationSiteLhs:
#if TARGET_OS_IOS || TARGET_OS_TV
                    if (@available(iOS 11.0, tvOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return CTVFLLayoutAttributeFirstBaseline;
                        }
                    }
#endif
                    return CTVFLLayoutAttributeTop;
                case CTVFLSyntaxEvaluationSiteRhs:
#if TARGET_OS_IOS || TARGET_OS_TV
                    if (@available(iOS 11.0, tvOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return CTVFLLayoutAttributeLastBaseline;
                        }
                    }
#endif
                    return CTVFLLayoutAttributeBottom;
            }
        case CTVFLOrientationHorizontal:
            switch (site) {
                case CTVFLSyntaxEvaluationSiteLhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return CTVFLLayoutAttributeLeft;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return CTVFLLayoutAttributeRight;
                        }
                    }
                    return CTVFLLayoutAttributeLeading;
                case CTVFLSyntaxEvaluationSiteRhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return CTVFLLayoutAttributeRight;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return CTVFLLayoutAttributeLeft;
                        }
                    }
                    return CTVFLLayoutAttributeTrailing;
            }
    }
}

static CTVFLLayoutAttribute _ViewGetAttribute(CTVFLSyntaxEvaluationSite site, CTVFLOrientation orientation, NSLayoutFormatOptions options) {
    switch (orientation) {
        case CTVFLOrientationVertical:
            switch (site) {
                case CTVFLSyntaxEvaluationSiteLhs:
#if TARGET_OS_IOS || TARGET_OS_TV
                    if (@available(iOS 11.0, tvOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return CTVFLLayoutAttributeLastBaseline;
                        }
                    }
#endif
                    return CTVFLLayoutAttributeBottom;
                case CTVFLSyntaxEvaluationSiteRhs:
#if TARGET_OS_IOS || TARGET_OS_TV
                    if (@available(iOS 11.0, tvOS 11.0, *)) {
                        if (options & NSLayoutFormatSpacingBaselineToBaseline) {
                            return CTVFLLayoutAttributeFirstBaseline;
                        }
                    }
#endif
                    return CTVFLLayoutAttributeTop;
            }
        case CTVFLOrientationHorizontal:
            switch (site) {
                case CTVFLSyntaxEvaluationSiteLhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return CTVFLLayoutAttributeRight;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return CTVFLLayoutAttributeLeft;
                        }
                    }
                    return CTVFLLayoutAttributeTrailing;
                case CTVFLSyntaxEvaluationSiteRhs:
                    if (options & NSLayoutFormatDirectionMask) {
                        if (options & NSLayoutFormatDirectionLeftToRight) {
                            return CTVFLLayoutAttributeLeft;
                        }
                        if (options & NSLayoutFormatDirectionRightToLeft) {
                            return CTVFLLayoutAttributeRight;
                        }
                    }
                    return CTVFLLayoutAttributeLeading;
            }
    }
}

id<CTVFLLayoutAnchor> _GetLayoutAnchor(id self, CTVFLLayoutAttribute attribute) {
    switch (attribute) {
        case CTVFLLayoutAttributeLeft:             return [self leftAnchor];
        case CTVFLLayoutAttributeRight:            return [self rightAnchor];
        case CTVFLLayoutAttributeTop:              return [self topAnchor];
        case CTVFLLayoutAttributeBottom:           return [self bottomAnchor];
        case CTVFLLayoutAttributeLeading:          return [self leadingAnchor];
        case CTVFLLayoutAttributeTrailing:         return [self trailingAnchor];
        case CTVFLLayoutAttributeWidth:            return [self widthAnchor];
        case CTVFLLayoutAttributeHeight:           return [self heightAnchor];
        case CTVFLLayoutAttributeCenterX:          return [self centerXAnchor];
        case CTVFLLayoutAttributeCenterY:          return [self centerYAnchor];
        case CTVFLLayoutAttributeLastBaseline:     return [self lastBaselineAnchor];
        case CTVFLLayoutAttributeFirstBaseline:    return [self firstBaselineAnchor];
    }
}
