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
    private:
        class Level {
        private:
            std::unique_ptr<std::list<NSLayoutConstraint *>> _constraints_;
            bool _collectsConstraints;
            
        public:
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
        
    public:
        Transaction(void);
        
        Transaction(const Transaction &transaction) = delete;
        
        ~Transaction(void);
        
        static Transaction& threadLocal(void);
        
        static Level& topLevel(void);
        
        static size_t levelsCount(void);
        
        static void begin(bool ensuresImplicit);
        
        static void commit(void);
        
        static void addConstraint(NSLayoutConstraint * constraint, bool enforces, bool ensuresImplicit);
        
        static void addConstraints(NSArray<NSLayoutConstraint *> * constraints, bool enforces, bool ensuresImplicit);
        
        static std::list<NSLayoutConstraint *>& constraints(void);
        
        static CTVFLEvaluationContext * sharedEvaluationContext(void);
        
        static void ensureImplicit(void);
    private:
        Level& _topLevel(void);
        
        size_t _levelsCount(void);
        
        void _push(void);
        
        void _pop(void);
        
        void _lock(void);
        
        void _unlock(void);
        
        void _ensureImplicit(void);
        
        CTVFLEvaluationContext * _sharedEvaluationContext(void);
    };
}

#endif /* CTVFLTransaction_Internal_h */
