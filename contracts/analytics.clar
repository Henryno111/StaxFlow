;; Analytics Functions
(define-private (update-route-analytics (source uint) (target uint) (amount uint))
    (let ((current-stats (default-to
        { success-count: u0,
          fail-count: u0,
          average-time: u0,
          total-volume: u0,
          last-updated: block-height }
        (map-get? route-analytics { source-chain: source, target-chain: target }))))
        (map-set route-analytics 
            { source-chain: source, target-chain: target }
            { success-count: (+ (get success-count current-stats) u1),
              fail-count: (get fail-count current-stats),
              average-time: (get average-time current-stats),
              total-volume: (+ (get total-volume current-stats) amount),
              last-updated: block-height })))