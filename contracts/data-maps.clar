;; Data Maps
(define-map supported-chains 
    uint 
    { chain-name: (string-utf8 32),
      enabled: bool,
      min-amount: uint,
      max-amount: uint,
      daily-limit: uint,
      success-rate: uint,
      average-time: uint })

(define-map bridge-operations
    (buff 32)  ;; transaction hash
    { initiator: principal,
      source-chain: uint,
      target-chain: uint,
      amount: uint,
      recipient: (buff 33),
      status: (string-utf8 16),
      timestamp: uint,
      points-earned: uint,
      fee-paid: uint,
      route-optimized: bool })

(define-map user-profiles
    principal
    { total-volume: uint,
      bridge-count: uint,
      flow-points-balance: uint,
      tier-level: uint,
      first-bridge: uint,
      last-bridge: uint,
      guardians: (list 3 principal) })

(define-map route-analytics
    { source-chain: uint, target-chain: uint }
    { success-count: uint,
      fail-count: uint,
      average-time: uint,
      total-volume: uint,
      last-updated: uint })

(define-map privacy-pool
    (buff 32)
    { commitment: (buff 32),
      nullifier: (buff 32),
      timestamp: uint })