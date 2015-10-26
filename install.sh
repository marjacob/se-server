#!/usr/bin/env bash

# wine
wine_home="/home/wine/.wine/drive_c/users/wine"
wine_appdata="${wine_home}/Application Data"

# space engineers
se_home="${wine_home}/DedicatedServer"
se_appdata="${wine_appdata}/SpaceEngineersDedicated"

# entry point
entry_point="/usr/local/bin/space-engineers-server"

# installation
cat << EOF > ${entry_point}
#!/usr/bin/env bash

unzip -qq "/host/DedicatedServer.zip" -d "${wine_home}/"
ln -s "/host/Space Engineers" "${se_appdata}"

chown -R wine:wine \
	"${se_appdata}/SpaceEngineers-Dedicated.cfg" \
	"${se_home}"

exec wine "${se_home}/SpaceEngineersDedicated.exe" "\$@"
EOF

chmod u+x "${entry_point}"
chown -R wine:wine "${entry_point}"

