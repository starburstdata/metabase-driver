(ns metabase.test.data.dataset-definition-test
  (:require
   [clojure.test :refer :all]
   [metabase.driver :as driver]
   [metabase.driver.ddl.interface :as ddl.i]
   [metabase.test :as mt]
   [toucan2.core :as t2]))

(deftest dataset-with-custom-pk-test
  (mt/test-drivers (disj (mt/sql-jdbc-drivers)
                         ;; presto doesn't create PK for test data :) not sure why
                         :presto-jdbc
                         ;; creating db for athena is expensive and require some extra steps,
                         ;; so it's not worth testing against, see [[metabase.test.data.athena/*allow-database-creation*]]
                         :athena
                         ;; there is no PK in sparksql
                         :sparksql)))

(deftest dataset-with-custom-composite-pk-test
  (mt/test-drivers (disj (mt/sql-jdbc-drivers)
                         ;; presto doesn't create PK for test data :) not sure why
                         :presto-jdbc
                         ;; creating db for athena is expensive and require some extra steps,
                         ;; so it's not worth testing against, see [[metabase.test.data.athena/*allow-database-creation*]]
                         :athena
                         ;; there is no PK in sparksql
                         :sparksql)))
