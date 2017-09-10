#!/usr/bin/env bash
path="${HOME}/unload-loopback.sh"
echo "#!/usr/bin/env bash" > ${path}
echo pactl unload-module $(pactl load-module module-loopback) >> ${path}
chmod +x "${path}"
echo "PulseAudio loopback module loaded. Execute ${path} to unload it"