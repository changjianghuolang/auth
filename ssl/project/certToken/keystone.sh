get_id () {
    echo `$@ | awk '/ id / { print $4 }'`
}


#tenantID=$(get_id keystone tenant-create --name "adminTenant" --description "AdminTenant" --enabled true) 
#keystone tenant-create --name adminTenant --description "Admin Tenant" --enabled true

if  [ 1 == 1 ] ;
then 
IP="192.168.1.105"
PORT="35357"

#1 create (tenant)
tenantID=$(get_id keystone tenant-create --name adminTenant --description "AdminTenant" --enabled true) 

#2 create TEST_admin account (user)
userID=$(get_id keystone user-create --tenant_id $tenantID --name "admin" --pass "openstack" --enabled true)

#3 create TEST_admin juer
roleID=$(get_id keystone role-create --name "adminRole")

echo "tenant-list"
keystone tenant-list >> 1
echo "user-list"
keystone user-list >> 1
echo "role-list"
keystone role-list >>1 

#Conect tenant-TEST_admin-juer
keystone user-role-add 	--user-id $userID --tenant-id $tenantID --role-id $roleID  

fi 


if [ 1 == 0 ] ;
then
#Cleanup 
keystone tenant-delete TEST_Tenant
keystone user-delete TEST_admin
keystone role-delete TEST_adminRole
keystone role-delete _member_

fi

curl -d '{"auth": {"tenantName": "adminTenant", "passwordCredentials":{"username": "admin", "password": "openstack"}}}' -H "Content-type: application/json" http://$IP:$PORT/v2.0/tokens | python -mjson.tool


