;; Utility Functions
(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(define-read-only (get-status-string (status-code uint))
    (if (is-eq status-code u0)
        (contract-call? .constants STATUS_PENDING)
        (if (is-eq status-code u1)
            (contract-call? .constants STATUS_COMPLETED)
            (contract-call? .constants STATUS_FAILED))))

(define-read-only (generate-tx-hash (amount uint) (recipient (buff 33)))
    (sha256 (concat (sha256 recipient) recipient)))

(define-read-only (calculate-points (amount uint))
    (* amount (contract-call? .data-vars points-per-stx)))

(define-read-only (calculate-fee (amount uint) (tier uint))
    (let ((base-fee (/ (* amount (contract-call? .data-vars protocol-fee-bps)) u10000)))
        (/ (* base-fee (- u100 tier)) u100)))