(ns metabase.driver.implementation.driver-helpers
  "Driver api implementation for Starburst driver."
  (:require [metabase.driver :as driver]))

;;; Starburst API helpers

(defmethod driver/db-start-of-week :starburst
  [_]
  :monday)

(doseq [[feature supported?] {:set-timezone                    true
                              :basic-aggregations              true
                              :standard-deviation-aggregations true
                              :expressions                     true
                              :native-parameters               true
                              :expression-aggregations         true
                              :binning                         true
                              :foreign-keys                    true}]
  (defmethod driver/supports? [:starburst feature] [_ _] supported?))
