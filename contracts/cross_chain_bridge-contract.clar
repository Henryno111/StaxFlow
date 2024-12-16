;; Cross-Chain Bridge Smart Contract
;; Version 2.0 - Main Contract File

(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)
(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; Bridge Operations
(define-public (bridge-tokens 
    (amount uint)
    (target-chain uint)
    (recipient (buff 33))
    (use-privacy-pool bool))
    (contract-call? .bridge-core initiate-bridge amount target-chain recipient use-privacy-pool))

;; Chain Management
(define-public (add-supported-chain 
    (chain-id uint)
    (chain-name (string-utf8 32))
    (min-amount uint)
    (max-amount uint)
    (daily-limit uint))
    (contract-call? .bridge-core set-supported-chain chain-id chain-name min-amount max-amount daily-limit))

;; User Profile Management
(define-public (set-user-guardians 
    (guardian-1 principal)
    (guardian-2 principal)
    (guardian-3 principal))
    (contract-call? .profile-manager set-guardians guardian-1 guardian-2 guardian-3))

;; Read-only functions
(define-read-only (get-bridge-tx (tx-hash (buff 32)))
    (contract-call? .read-only get-bridge-details tx-hash))

(define-read-only (get-user-stats (user principal))
    (contract-call? .read-only get-user-profile user))

(define-read-only (get-bridge-stats)
    (contract-call? .read-only get-protocol-stats))