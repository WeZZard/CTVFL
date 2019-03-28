//
//  NSLayoutConstraint+CTVFL.m
//  CTVFL
//
//  Created by Yu-Long Li on 2019/3/27.
//

#import "NSLayoutConstraint+CTVFL.h"

@implementation NSLayoutConstraint (CTVFL)
- (id<CTVFLNSLayoutConstrained>)_ctvfl_firstItem
{
    return [self firstItem];
}

- (id<CTVFLNSLayoutConstrained>)_ctvfl_secondItem
{
    return [self secondItem];
}

#if TARGET_OS_OSX
+ (instancetype)_ctvfl_constraintWithItem:(id<CTVFLNSLayoutConstrained>)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(id<CTVFLNSLayoutConstrained>)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c
{
    return [NSLayoutConstraint constraintWithItem: view1 attribute: attr1 relatedBy: relation toItem: view2 attribute: attr2 multiplier: multiplier constant: c];
}
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
+ (instancetype)_ctvfl_constraintWithItem:(id<CTVFLNSLayoutConstrained>)view1
                                attribute:(NSLayoutAttribute)attr1
                                relatedBy:(NSLayoutRelation)relation
                                   toItem:(id<CTVFLNSLayoutConstrained>)view2
                                attribute:(NSLayoutAttribute)attr2
                               multiplier:(CGFloat)multiplier
                                 constant:(CGFloat)c
{
    return [NSLayoutConstraint constraintWithItem: view1 attribute: attr1 relatedBy: relation toItem: view2 attribute: attr2 multiplier: multiplier constant: c];
}
#endif
@end
