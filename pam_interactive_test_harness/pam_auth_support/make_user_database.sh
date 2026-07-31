#! /bin/bash

# This script is required for testing PAM authentication using the
# pam_interactive authentication scheme. It generates a user database
# which is meant to be used by PAM for verifying user credentials.

set -x

users_file=users.txt
db_file=pam_userdb.db

# Generate key-value pairs. These represent entries in the database.
# The first line is the username. It is also used as the key for looking
# up the entry. The second line is the password for the user.
second_password=$(openssl passwd -6 "otherrods")
cat > "$users_file" <<EOF
john
$second_password
EOF

# Show the contents of the input file for visual inspection.
cat -A "$users_file"

# Generate the user database file needed by the pam_userdb module.
rm -f "$db_file"
db_load -T -t hash -f "$users_file" "$db_file"
chown root:root "$db_file"
chmod 600 "$db_file"

# Show the contents of the user database.
db_dump -p "$db_file"
