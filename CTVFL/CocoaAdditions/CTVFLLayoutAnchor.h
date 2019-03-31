//
//  CTVFLLayoutAnchor.h
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

NS_ASSUME_NONNULL_BEGIN

__attribute__((visibility("hidden")))
@protocol CTVFLLayoutAnchor<NSObject>
- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor constant:(CGFloat)constant;

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toAnchor:(id<CTVFLLayoutAnchor>)anchor;

- (NSLayoutConstraint *)_ctvfl_constraintWithRelation:(NSLayoutRelation)relation toConstant:(CGFloat)constant;
@end

__attribute__((visibility("hidden")))
@interface NSLayoutAnchor (CTVFLLayoutAnchor)<CTVFLLayoutAnchor>
@end

NS_ASSUME_NONNULL_END
