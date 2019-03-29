//
//  CTVFLTransaction+Internal.h
//  CTVFL
//
//  Created by WeZZaard on 2019/3/29.
//

#ifndef CTVFLTransaction_Internal_h
#define CTVFLTransaction_Internal_h

#include <os/lock.h>

#include <memory>
#include <list>

#import "CTVFLTransaction.h"

namespace CTVFL {
    class Transaction;
    
    class Transaction {
    public:
        class Level {
        private:
            CTVFLTransaction * _transaction_;
            std::unique_ptr<std::list<NSLayoutConstraint *>> _constraints_;
            bool _collectsConstraints;
            
        public:
            CTVFLTransaction * transaction(void);
            
            Level(bool collectsConstraints);
            
            ~Level(void);
            
            void addConstraint(NSLayoutConstraint *, bool);
            
            void addConstraints(NSArray<NSLayoutConstraint *> *, bool);
            
            std::list<NSLayoutConstraint *>& constraints(void);
        };
        
    private:
        CFRunLoopObserverRef _runLoopObserver_;
        std::unique_ptr<std::list<Level>> _levels_;
        CTVFLEvaluationContext * _sharedEvaluationContext_;
        pthread_mutex_t _lock_;
        
    public:
        Transaction(void);
        
        Transaction(const Transaction &transaction) = delete;
        
        ~Transaction(void);
        
        static Transaction& threadLocal(void);
        
        static void begin(void);
        
        static void commit(void);
        
        static void lock(void);
        
        static void unlock(void);
        
        Level& topLevel(void);
        
        size_t levelsCount(void);
        
        void push(void);
        
        void pop(void);
        
        void _lock(void);
        
        void _unlock(void);
        
        CTVFLEvaluationContext * sharedEvaluationContext(void);
    };
}

#endif /* CTVFLTransaction_Internal_h */
