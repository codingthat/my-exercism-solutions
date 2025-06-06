(ns word-count
  (:require [clojure.string :as str]))

(def word-count
  (comp
    frequencies ; create a hashmap of frequencies
    #(str/split % #"\W+") ; from words split by multiple non-[a-zA-Z0-9_] characters
    str/lower-case) ; from the input converted to lower-case
)