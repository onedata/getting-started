# Config files

This directory contains config files for production deployment of 
onezone on onedata.org and beta.onedata.org.

They are not used automatically, rather than that they should be moved
to proper locations so they can be mounted during start of service
(see docker compose for volume paths).

NOTE: While dns.config stays rather unchanged, app.config tends to
change rapidly, so it's best to double check before using the one here.
If changes are detected, it should be updated ASAP.

NOTE: these are not all configuration files that are expected by 
onezone. The others include e.g. auth.config and server certificates.