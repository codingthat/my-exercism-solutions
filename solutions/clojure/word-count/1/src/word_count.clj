(ns word-count
  (:require [clojure.string :as str]))

(defn increment-count [res pair] ; current hash-map of counts, pair whose index-1 value is a word to count
  (assoc res (pair 1) ; new map, make the new word count be:
    (+
      (or (res (pair 1)) 0) ; existing value, otherwise zero...
      1 ; plus one
    )
  )
)

(defn word-count [input]
  (reduce increment-count
    {}
    (re-seq #"[^a-z0-9]?([a-z0-9]+)[^a-z0-9]?" (str/lower-case input))
  )
)