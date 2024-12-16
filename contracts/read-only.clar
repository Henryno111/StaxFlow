;; Read-only Functions
(define-read-only (get-bridge-details (tx-hash (buff 32)))
    (map-get? bridge-operations tx-hash))

(define-read-only (get-user-profile (user principal))
    (ok (default-user-profile user)))

(define-read-only (get-route-stats (source uint) (target uint))
    (map-get? route-analytics { source-chain: source, target-chain: target }))

(define-read-only (get-protocol-stats)
    (ok { version: BRIDGE_VERSION,
         total-volume: (var-get total-volume),
         total-bridges: (var-get total-bridges),
         current-fee-bps: (var-get protocol-fee-bps),
         points-rate: (var-get points-per-stx) }))