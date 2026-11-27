# SPDX-License-Identifier: MIT
package require tsession 2.0.3
package require tsession::sql 2.0.3
namespace eval ::tsession::mysql {}

proc ::tsession::mysql::create {args} {
    ::tsession::sql::create mysql {*}$args
}

proc ::tsession::mysql::initdb {connection} {
    ::tsession::sql::initdb $connection mysql
}

package provide tsession-mysql 1.0.1
