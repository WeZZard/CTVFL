//
//  CTVFLLayoutAnchor.m
//  CTVFL
//
//  Created on 2019/3/28.
//

#import "CTVFLLayoutAnchor.h"

@implementation NSLayoutAnchor (CTVFLLayoutAnchor)
- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor constant:(CGFloat)constant
{
    [NSException raise: NSInvalidArgumentException format: @"Abstract method."];
    return nil;
}

#if TARGET_OS_IOS || TARGET_OS_TV
- (NSLayoutConstraint *)_ctvfl_constraintUsingSystemSpacingWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor
{
    [NSException raise: NSInvalidArgumentException format: @"Abstract method."];
    return nil;
}
#endif

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor;
{
    [NSException raise: NSInvalidArgumentException format: @"Abstract method."];
    return nil;
}

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toConstant:(CGFloat)constant
{
    [NSException raise: NSInvalidArgumentException format: @"Abstract method."];
    return nil;
}
@end

@implementation NSLayoutXAxisAnchor (CTVFLLayoutAnchor)
- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor constant:(CGFloat)constant
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutXAxisAnchor * another = (NSLayoutXAxisAnchor *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another constant: constant];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another constant: constant];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another constant: constant];
    }
}

#if TARGET_OS_IOS || TARGET_OS_TV
- (NSLayoutConstraint *)_ctvfl_constraintUsingSystemSpacingWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor
{
    if (@available(iOS 11.0, tvOS 11.0, *)) {
        NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
        NSLayoutXAxisAnchor * another = (NSLayoutXAxisAnchor *)anchor;
        switch (relation) {
            case NSLayoutRelationEqual:
                return [self constraintEqualToSystemSpacingAfterAnchor:another multiplier:1];
            case NSLayoutRelationLessThanOrEqual:
                return [self constraintLessThanOrEqualToSystemSpacingAfterAnchor:another multiplier:1];
            case NSLayoutRelationGreaterThanOrEqual:
                return [self constraintGreaterThanOrEqualToSystemSpacingAfterAnchor:another multiplier:1];
        }
    } else {
        [NSException raise: NSInvalidArgumentException format: @"Not implemented."];
        return nil;
    }
}
#endif

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor;
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutXAxisAnchor * another = (NSLayoutXAxisAnchor *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another];
    }
}
@end

@implementation NSLayoutYAxisAnchor (CTVFLLayoutAnchor)
- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor constant:(CGFloat)constant
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutYAxisAnchor * another = (NSLayoutYAxisAnchor *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another constant: constant];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another constant: constant];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another constant: constant];
    }
}

#if TARGET_OS_IOS || TARGET_OS_TV
- (NSLayoutConstraint *)_ctvfl_constraintUsingSystemSpacingWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor
{
    if (@available(iOS 11.0, tvOS 11.0, *)) {
        NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
        NSLayoutYAxisAnchor * another = (NSLayoutYAxisAnchor *)anchor;
        switch (relation) {
            case NSLayoutRelationEqual:
                return [self constraintEqualToSystemSpacingBelowAnchor:another multiplier:1];
            case NSLayoutRelationLessThanOrEqual:
                return [self constraintLessThanOrEqualToSystemSpacingBelowAnchor:another multiplier:1];
            case NSLayoutRelationGreaterThanOrEqual:
                return [self constraintGreaterThanOrEqualToSystemSpacingBelowAnchor:another multiplier:1];
        }
    } else {
        [NSException raise: NSInvalidArgumentException format: @"Not implemented."];
        return nil;
    }
}
#endif

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor;
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutYAxisAnchor * another = (NSLayoutYAxisAnchor *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another];
    }
}
@end

@implementation NSLayoutDimension (CTVFLLayoutAnchor)
- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor constant:(CGFloat)constant
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutDimension * another = (NSLayoutDimension *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another constant: constant];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another constant: constant];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another constant: constant];
    }
}

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toConstant:(CGFloat)constant
{
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToConstant:constant];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToConstant: constant];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToConstant: constant];
    }
}

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor;
{
    NSParameterAssert([anchor isKindOfClass: [NSLayoutAnchor class]]);
    NSLayoutDimension * another = (NSLayoutDimension *)anchor;
    switch (relation) {
        case NSLayoutRelationEqual:
            return [self constraintEqualToAnchor: another];
        case NSLayoutRelationLessThanOrEqual:
            return [self constraintLessThanOrEqualToAnchor: another];
        case NSLayoutRelationGreaterThanOrEqual:
            return [self constraintGreaterThanOrEqualToAnchor: another];
    }
}
@end
