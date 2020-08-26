# Kea DHCP Docker image

## Information

 * Kea DHCPv4 / DHCPv6 / DDNS / Ctrl-Agent - using binary packages for Ubuntu 20.04
 * Supervisord to allow running multiple Kea components in single container
 * Specific Kea components can be disabled
 * Auto database install/upgrade using official kea-admin tool (db-init / db-upgrade)

## Configuration

### Environment variables

 * `DISABLE_DHCP4=1` - Don't run kea-dhcp4
 * `DISABLE_DHCP6=1` - Don't run kea-dhcp6
 * `DISABLE_DHCP_DDNS=1` - Don't run kea-dhcp-ddns
 * `DISABLE_CTRL_AGENT=1` - Don't run kea-ctrl-agent
 * `DB_ADMIN_PARAMS=pgsql ...` - Parameters passed to kea-admin database migration tool. No db-init/db-upgrade commands are run when empty

### Config files

Configuration files should be mounted to `/kea/config`.
Each Kea component uses seperate configuration file:

 * kea-dhcp4.conf
 * kea-dhcp6.conf
 * kea-dhcp-ddns.conf
 * kea-ctrl-agent.conf

## Example

```
docker run \
  --rm --name kea \
  --network host \
  -v /path_to_kea_config:/kea/config:ro \
  -e DISABLE_DHCP6=1 -e DISABLE_CTRL_AGENT=1 \
  -e "DB_ADMIN_PARAMS=pgsql -h 127.0.0.1 -u kea -n kea -p db_password" \
  bslawianowski/kea:latest
```

