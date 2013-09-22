curl -d '{"auth": {"tenantName": "adminTenant", "passwordCredentials":{"username": "admin", "password": "openstack"}}}' -H "Content-type: application/json" http://10.172.7.81:35357/v2.0/tokens | python -mjson.tool


