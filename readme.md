# tsession-mysql

This adapter stores tenant-scoped sessions on a borrowed MySQL 8 connection. The caller owns the connection and its transactions.

```tcl
package require tsession-mysql
set db [::tpersist::db_connect_config $connectionConfig]
try {
    ::tsession::mysql::initdb $db
    set store [::tsession::mysql::create -connection $db -tenant example]
    set expires [expr {[clock seconds] + 3600}]
    ::tsession::sql::insert $store sample [dict create expires $expires] member
    set session [::tsession::sql::get $store sample]
} finally {
    ::tpersist::db_disconnect $db
}
```

Supply a `tpersist` connection dictionary with `db_dialect mysql` and a `mysql` dictionary of driver options. Apply the schema once at startup. The shared `tsession::sql` API provides insert, get, update, delete, revoke and prune. Provision the database with `utf8mb4_0900_bin` collation so new session tables distinguish case and trailing spaces in identifiers.

Install with CMake or place the checkout on `TCLLIBPATH`. To run the integration tests, set `TSESSION_TEST_MYSQL` to the TDBC connection options for a disposable database, then run `tclsh tests/all.tcl`.
