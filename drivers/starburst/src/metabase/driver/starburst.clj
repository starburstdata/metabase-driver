(ns metabase.driver.starburst
  "Starburst driver."
  (:require [metabase.driver :as driver]
                        [metabase.driver.sql-jdbc.execute.legacy-impl :as sql-jdbc.legacy]))
(driver/register! :starburst, :parent #{::sql-jdbc.legacy/use-legacy-classes-for-read-and-set})
 
(prefer-method driver/supports? [:starburst :set-timezone] [:sql-jdbc :set-timezone])

;;; +----------------------------------------------------------------------------------------------------------------+
;;; |                                                  Load implemetation files                                      |
;;; +----------------------------------------------------------------------------------------------------------------+
(load "implementation/query_processor")
(load "implementation/sync")
(load "implementation/execute")
(load "implementation/connectivity")
(load "implementation/unprepare")
(load "implementation/driver_helpers")
