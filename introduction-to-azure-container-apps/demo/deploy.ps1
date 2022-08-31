$grp = "ACADemo5RG"
$loc = "eastus"
$environment = "aca-demo-env"
$serverName="sqlserver20220901"
$databaseName="mydatabase20220901"

# creating resource group
az group create --name $grp `
    --location $loc

# creating sql server
az sql server create -l $loc -g $grp -n $serverName -u kamal -p Hello@12345#

# creating sql server database
az sql db create --resource-group $grp --server $serverName --name $databaseName --edition Standard --zone-redundant false --backup-storage-redundancy Local
az sql server firewall-rule create --name allowingall --server $serverName --resource-group $grp --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

$connectionString = "Server=tcp:<server>.database.windows.net,1433;Initial Catalog=<db>;Persist Security Info=False;User ID=<user>;Password=<password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;".replace('<user>', 'kamal').replace('<password>','Hello@12345#').replace('<server>', $serverName).replace('<db>', $databaseName)

# creating environment
az containerapp env create --name $environment `
--resource-group $grp `
--location $loc

# creating the users app
az containerapp create `
--name aca-demo-app `
--resource-group $grp `
--environment $environment `
--image kamalrathnayake/countriesapp `
--target-port 80 `
--ingress 'external' `
--min-replicas 0 `
--max-replicas 5 `
--env-vars "ConnectionString=$connectionString"


az containerapp delete -g $grp -n aca-demo-app --yes
az containerapp env delete -n $environment -g $grp --yes

az group delete --resource-group $grp --yes