;; Profile Management Functions
(define-private (update-user-profile (user principal) (amount uint) (points uint))
    (let ((current-profile (default-user-profile user)))
        (map-set user-profiles user
            (merge current-profile
                  { total-volume: (+ (get total-volume current-profile) amount),
                    bridge-count: (+ (get bridge-count current-profile) u1),
                    flow-points-balance: (+ (get flow-points-balance current-profile) points),
                    last-bridge: block-height }))))

(define-public (set-guardians (guardian-1 principal) (guardian-2 principal) (guardian-3 principal))
    (begin
        (asserts! (not (is-eq guardian-1 guardian-2)) ERR_INVALID_GUARDIAN)
        (asserts! (not (is-eq guardian-2 guardian-3)) ERR_INVALID_GUARDIAN)
        (asserts! (not (is-eq guardian-1 guardian-3)) ERR_INVALID_GUARDIAN)
        (ok (map-set user-profiles tx-sender
            (merge (default-user-profile tx-sender)
                  { guardians: (list guardian-1 guardian-2 guardian-3) })))))