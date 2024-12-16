;; Core Bridge Functions
(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; Initialize or update chain support
(define-public (set-supported-chain 
    (chain-id uint) 
    (chain-name (string-utf8 32))
    (min-amount uint)
    (max-amount uint)
    (daily-limit uint))
    (begin
        (asserts! (is-eq tx-sender (contract-call? .constants get-contract-owner)) 
                 (contract-call? .constants ERR_NOT_AUTHORIZED))
        (ok (map-set supported-chains chain-id
            { chain-name: chain-name,
              enabled: true,
              min-amount: min-amount,
              max-amount: max-amount,
              daily-limit: daily-limit,
              success-rate: u0,
              average-time: u0 }))))

;; Initiate bridge transfer
(define-public (initiate-bridge 
    (amount uint)
    (target-chain uint)
    (recipient (buff 33))
    (use-privacy-pool bool))
    (let ((chain-info (unwrap! (map-get? supported-chains target-chain) 
                              (contract-call? .constants ERR_CHAIN_NOT_SUPPORTED)))
          (tx-hash (contract-call? .utils generate-tx-hash amount recipient))
          (points-to-earn (contract-call? .utils calculate-points amount))
          (fee (contract-call? .utils calculate-fee amount 
                (contract-call? .profile-manager get-user-tier tx-sender))))
        (begin
            (asserts! (not (contract-call? .data-vars get-contract-status)) 
                     (contract-call? .constants ERR_BRIDGE_PAUSED))
            (asserts! (>= amount (get min-amount chain-info)) 
                     (contract-call? .constants ERR_INVALID_AMOUNT))
            (asserts! (<= amount (get max-amount chain-info)) 
                     (contract-call? .constants ERR_INVALID_AMOUNT))
            
            (if use-privacy-pool
                (try! (contract-call? .privacy-pool process-private-transfer amount tx-hash))
                (try! (stx-transfer? amount tx-sender (as-contract tx-sender))))
            
            (try! (ft-mint? flow-points points-to-earn tx-sender))
            
            (contract-call? .analytics update-route-analytics u1 target-chain amount)
            (contract-call? .profile-manager update-user-profile tx-sender amount points-to-earn)
            
            (ok tx-hash))))