(ns bob
  (:require
     [clojure.string :refer [trim ends-with?]]))

(defn response-for [speech]
  (if (= (trim speech) "")
    (str "Fine. Be that way!") ; Spaces only or empty string.
    (if (and (re-find #"[A-Z]" speech) (not (re-find #"[a-z]" speech)))
      (str "Whoa, chill out!") ; Caps, no smallcase.
      (if (ends-with? speech "?")
        (str "Sure.") ; Not-all-caps question.
        (str "Whatever.") ; Not-all-caps anything else.
      )      
    )
  )
)