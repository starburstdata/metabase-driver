## [Unreleased]
-   Fix an issue where long queries get an error before they complete
-   Add cancel support for statements

## [6.0.0] - 2025-01-10

-   Bump Metabase version to v1.52.2
-   Re-enable the :foreign-keys feature flag so that users can set external relationships in Metabase

## [4.1.0] - 2023-11-17

-   Add a new "Optimized prepared statement" option when defining a database
-   Add further detail in the query comments such as account ID, dashboard ID or card ID when available

## [4.0.0] - 2023-09-27

-   Dump Metabase version to v1.47.2
-   Fix timestamp filter issue with version 1.47.x
-   Add an impersonation option when defining a Starburst database

## [3.0.1] - 2023-05-25

-   Bump Metabase version to v1.46.4

## [3.0.0] - 2023-05-18

-   Bump Metabase version to v1.46.3
-   Migrate to Honey SQL 2
-   Refactor unit test catalogs
-   Enable now support
-   Set metabase version to patch branch 

## [2.0.0] - 2023-03-06

-   Bump Metabase version to v1.45.0
-   Adds [convertTimezone](https://www.metabase.com/docs/latest/questions/query-builder/expressions/converttimezone) support
-   Adds [datetimeDiff](https://www.metabase.com/docs/latest/questions/query-builder/expressions/datetimediff) support

## [1.0.7] - 2022-12-12

-   Update trino test port to 8082
-   Add optional role field in the connection form

## [1.0.6] - 2022-08-16

-   Remove prepared statements from sync

## [1.0.6-RC-1] - 2022-08-11

-   Bump Metabase version to v1.44.0
-   Disable Foreign Key feature

## [1.0.5] - 2022-07-11

-   Add default-advanced-options
-   Update README.md

## [1.0.4] - 2022-06-29

-   Updates to MAKEFILE to support mainline metabase
-   Remove Gitmodules dir
-   fix null pointer issues releated to TIMESTAMP WTZ, TIME, and TIME WTZ

## [1.0.3] - 2022-06-09

-   Adds contact info

## [1.0.2] - 2022-06-08

-   Overrides JDBC source info

## [1.0.1] - 2022-06-07

-   Updates release workflows in github

## [1.0.0] - 2022-06-07

-   Adds Starburst driver that implements JDBC SQL multi methods
-   Adds Starburst specific tests
-   Adds github CI actions for testing and release

[Unreleased]: https://github.com/starburstdata/metabase-driver/compare/6.0.0...HEAD

[6.0.0]: https://github.com/starburstdata/metabase-driver/compare/5.0.0...6.0.0

[5.0.0]: https://github.com/starburstdata/metabase-driver/compare/4.1.0...5.0.0

[4.1.0]: https://github.com/starburstdata/metabase-driver/compare/4.0.0...4.1.0

[4.0.0]: https://github.com/starburstdata/metabase-driver/compare/3.0.0...4.0.0

[3.0.0]: https://github.com/starburstdata/metabase-driver/compare/2.0.0...3.0.0

[2.0.0]: https://github.com/starburstdata/metabase-driver/compare/1.0.7...2.0.0

[1.0.7]: https://github.com/starburstdata/metabase-driver/compare/1.0.6...1.0.7

[1.0.6]: https://github.com/starburstdata/metabase-driver/compare/1.0.6-RC-1...1.0.6

[1.0.6-RC-1]: https://github.com/starburstdata/metabase-driver/compare/1.0.5...1.0.6-RC-1

[1.0.5]: https://github.com/starburstdata/metabase-driver/compare/1.0.4...1.0.5

[1.0.4]: https://github.com/starburstdata/metabase-driver/compare/1.0.3...1.0.4

[1.0.3]: https://github.com/starburstdata/metabase-driver/compare/1.0.2...1.0.3

[1.0.2]: https://github.com/starburstdata/metabase-driver/compare/1.0.1...1.0.2

[1.0.1]: https://github.com/starburstdata/metabase-driver/compare/1.0.0...1.0.1

[1.0.0]: https://github.com/starburstdata/metabase-driver/compare/bf93d37ea60c119bc62f627cd6c8ca6aff4948ab...1.0.0
