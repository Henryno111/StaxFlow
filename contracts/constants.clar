;; Constants and Error Codes
(define-constant CONTRACT_OWNER tx-sender)
(define-constant BRIDGE_VERSION "2.0.0")

;; Error codes
(define-constant ERR_NOT_AUTHORIZED (err u401))
(define-constant ERR_INVALID_AMOUNT (err u402))
(define-constant ERR_BRIDGE_PAUSED (err u403))
(define-constant ERR_CHAIN_NOT_SUPPORTED (err u404))
(define-constant ERR_INSUFFICIENT_POINTS (err u405))
(define-constant ERR_INVALID_GUARDIAN (err u406))
(define-constant ERR_COOLDOWN_ACTIVE (err u407))

;; Status Constants with fixed length of 16 chars
(define-constant STATUS_PENDING "pending         ")
(define-constant STATUS_COMPLETED "completed       ")
(define-constant STATUS_FAILED "failed          ")

;; Export read-only functions
(define-read-only (get-contract-owner)
    CONTRACT_OWNER)

(define-read-only (get-bridge-version)
    BRIDGE_VERSION)