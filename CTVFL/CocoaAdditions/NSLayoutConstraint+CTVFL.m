//
//  NSLayoutConstraint+CTVFL.m
//  CTVFL
//
//  Created by Yu-Long Li on 2019/3/27.
//

#import "NSLayoutConstraint+CTVFL.h"

@implementation NSLayoutConstraint (CTVFL)
- (id<CTVFLLayoutAnchorSelectable>)_ctvfl_firstItem
{
    return [self firstItem];
}

- (id<CTVFLLayoutAnchorSelectable>)_ctvfl_secondItem
{
    return [self secondItem];
}
@end
