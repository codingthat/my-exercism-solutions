(ns bob)

(defn response-for [speech]
  (if (re-find #"[A-Z]" speech)
    (if (re-find #"[a-z]" speech)
      (if (re-find #"\?$" speech)
        (str "Sure.") ; Mixed case question.
        (str "Whatever.") ; Mixed case statement.
      )
      (str "Whoa, chill out!") ; All caps.
    )
    (if (re-find #"\?$" speech)
      (str "Sure.") ; No-caps question.
      (if (re-find #"^ *$" speech)
        (str "Fine. Be that way!") ; Spaces only or empty string.
        (str "Whatever.") ; No-caps statement.
      )
    )
  )
)