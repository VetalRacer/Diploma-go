## Devops School

#### Task
Create a simple Web-application (see the description below) and CI/CD infrastructure and pipeline for it.
#### Description Application
To attract hockey fans to the marketing campaign you will need to analyze the statistics of three last seasons and provide information about people who take part in all-stars-game and the final game of those seasons and output a list of them with statistics of the final games. Use https://gitlab.com/dword4/nhlapi API, all the required data must be stored in a local database.

## Description Result
#### Prepare Azure Devops
- Register service principal in azure
- Add variables in Libarary as Infrastructure for Azure Devops:
  * ARM_CLIENT_ID - sp id
  * ARM_CLIENT_SECRET - sp secret
  * ARM_SUBSCRIPTION_ID - subscription id
  * ARM_TENANT_ID - sp tennaut id
  * DB_PASS - database password
  * REGISTRY_PASSWORD - registry password
  * ResourceGroupLocation - resource groups lication
  * StorageAccountName - name storage accout for terraform
  * domain - your domain

#### Deploy Infrastructure
- Run pipline for the infrastructure brunch.
Please note, if it is first deploy infrastructure then use commit as 'firstdeploy', for next infrastructure deploy use diffrent commit name.

#### Deploy App
- After infrastructure deploy you have to registry project in Sonar Qube and add variables in Library Azure Devops 
  * SONAR_HOST - Sonar Qube host
  * SONAR_PROJECT_ID - id for your project in Sonar Qube
- Run pipline for develop or/and release  brunches

#### Destroy all
- Run pipline for destroy_all brunche
- Delete manual resource group with StorageAccountName name
