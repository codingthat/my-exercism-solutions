(ns rna-transcription
  (:require [clojure.string :as str]))

(defn to-rna [dna]
  (assert (not (re-find #"[^CATG]" dna)) "This isn't a DNA strand!")
  (str/join (map {
    "C" "G"
    "G" "C"
    "T" "A"
    "A" "U"
  } (str/split dna #"")))
)