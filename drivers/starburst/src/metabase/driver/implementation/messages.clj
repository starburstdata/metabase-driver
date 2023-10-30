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
(ns metabase.driver.implementation.messages "Starburst messages")

(def STARBURST_INCOMPATIBLE_WITH_OPTIMIZED_PREPARED "\"Optimized prepared statements\" require Starburst Galaxy, Starburst Enterprise (version 420-e or higher), or Trino (version 418 or higher)")
(def STARBURST_MAYBE_INCOMPATIBLE ". If the database has the \"Optimized prepared statements\" option on, it require Starburst Galaxy, Starburst Enterprise (version 420-e or higher), or Trino (version 418 or higher)")
(def TOO_MANY_PARAMETERS "It looks like we got more parameters than we can handle, remember that parameters cannot be used in comments or as identifiers.")
