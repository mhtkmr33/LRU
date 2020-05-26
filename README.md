# LRU

1. Implemented the LRU (Leasr recently used) using siwft generics
2. Can define the type for Key-Value pairs dynamically

# USAGE:

let lru = LRU<Int, String>(maxCapacity: 3)
          lru.set(key: 1, value: "L")
          lru.set(key: 2, value: "R")
          lru.set(key: 3, value: "U")
          lru.getValue(key: 3)

Get Value function will display "U".

