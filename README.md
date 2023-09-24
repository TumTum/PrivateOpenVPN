VPN Server
----------

Eigen verwalteter Server in Ubuntu 22.04.

nach Anleitung von:

https://www.digitalocean.com/community/tutorials/how-to-set-up-an-ikev2-vpn-server-with-strongswan-on-ubuntu-22-04


1. IP und Domain anpassen:
in der Datei: [Platybook](playbook.yml) Domain anpassen

```yaml
  var:
    domain: 'EINE-DOMAIN.DE'
```
und in der [Inventory](inventory.ini) die IP des Server hinterlegen.
