//
//  CTVFLTransaction+Implicit.h
//  CTVFL
//
//  Created by WeZZaard on 2019/3/29.
//

#import "CTVFLTransaction.h"

@interface CTVFLTransaction(Implicit)
@property (nonatomic, class, readonly) BOOL _isImplicit;
@property (nonatomic, class, readonly) BOOL _hasNoTransactionsRunning;
@end

