;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at

;;     http://www.apache.org/licenses/LICENSE-2.0

;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
;;
(ns metabase.driver.starburst
  "Starburst driver."
  (:require [metabase.driver :as driver]
            [clojure.java.jdbc :as jdbc]
            [clojure.tools.logging :as log]
            [metabase.util.ssh :as ssh]
            [metabase.driver.sql-jdbc.connection :as connection]
            [metabase.query-processor.util :as qp.util]
            [metabase.public-settings :as public-settings]
            [metabase.driver.implementation.messages :as msg]
            [metabase.driver.sql-jdbc.execute.legacy-impl :as sql-jdbc.legacy]))
(driver/register! :starburst, :parent #{::sql-jdbc.legacy/use-legacy-classes-for-read-and-set})
 
(prefer-method driver/database-supports? [:starburst :set-timezone] [:sql-jdbc :set-timezone])

(defn format-field
  [name value]
  (if (nil? value)
    ""
    (str " " name ": " value)))

(defmethod qp.util/query->remark :starburst
  [_ {{:keys [card-id dashboard-id]} :info, :as query}]
  (str
    (qp.util/default-query->remark query)
    (format-field "accountID" (public-settings/site-uuid))
    (format-field "dashboardID" dashboard-id)
    (format-field "cardID" card-id)))

(defn handle-execution-error
  [e details]
  (let [message (.getMessage e)
        execute-immediate (get details :prepared-optimized false)]
    (cond
      (and (clojure.string/includes? message "Expecting: 'USING'") execute-immediate)
      (throw (Exception. msg/STARBURST_INCOMPATIBLE_WITH_OPTIMIZED_PREPARED))
      :else (throw e))))

(defmethod driver/can-connect? :starburst
  [driver details]
  (try
    (connection/with-connection-spec-for-testing-connection [jdbc-spec [driver details]]
      (connection/can-connect-with-spec? jdbc-spec))
    (catch Throwable e (handle-execution-error e details))))

;;; +----------------------------------------------------------------------------------------------------------------+
;;; |                                                  Load implemetation files                                      |
;;; +----------------------------------------------------------------------------------------------------------------+
(load "implementation/query_processor")
(load "implementation/sync")
(load "implementation/execute")
(load "implementation/connectivity")
(load "implementation/unprepare")
(load "implementation/driver_helpers")
