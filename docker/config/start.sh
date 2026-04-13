#!/bin/bash

# set up the jupyter notebook
if [ "x$TUTORIAL_PASSWORD" = "x" ]; then
    TUTORIAL_PASSWORD="citeams-2026"
fi
if [ "x$TUTORIAL_BASE_URL" = "x" ]; then
    TUTORIAL_BASE_URL="/"
fi
ENCPASSWORD=$(python3 -c "from jupyter_server.auth import passwd;print(passwd(\"$TUTORIAL_PASSWORD\"))")
mkdir -p /home/citeams/.jupyter
cat > /home/citeams/.jupyter/jupyter_server_config.json <<EOF
{ "ServerApp":
   {
        "base_url": "$TUTORIAL_BASE_URL"
   },
   "IdentityProvider":
   {
        "hashed_password": "$ENCPASSWORD"
   }
}
EOF
chown -R citeams: /home/citeams/.jupyter

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
