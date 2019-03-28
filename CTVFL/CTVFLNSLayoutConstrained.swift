//
//  CTVFLNSLayoutConstrained.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

extension Sequence where Element: CTVFLNSLayoutConstrained {
    internal var _commonAncestor: CTVFLView? {
        var countForID = [ObjectIdentifier : Int]()
        
        let baseViews = ContiguousArray<CTVFLView>(self.map({
            if let aView = $0 as? CTVFLView {
                return aView
            } else {
                return $0._ctvfl_ancestor
            }
        }).compactMap({$0}))
        
        let inputViewCount = baseViews.count
        
        var ancestorViews = baseViews
        
        while !ancestorViews.isEmpty {
            let nextAncestor = ancestorViews.removeFirst()
            
            let ancestorID = ObjectIdentifier(nextAncestor)
            
            if var count = countForID[ancestorID] {
                count += 1
                if count < inputViewCount {
                    countForID[ancestorID] = count
                } else {
                    return nextAncestor
                }
            } else {
                if 1 < inputViewCount {
                    countForID[ancestorID] = 1
                } else {
                    return nextAncestor._ctvfl_ancestor
                }
            }
            
            if let nextAncestor = nextAncestor._ctvfl_ancestor {
                ancestorViews.append(nextAncestor)
            }
        }
        
        return nil
    }
}
