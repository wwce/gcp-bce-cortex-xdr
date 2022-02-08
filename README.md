## Cortex XDR Endpoint Verification for BeyondCorp Enterprise

Cortex XDR and Cortex Data Lake are cloud services provided by Palo Alto Networks and are running in Google Cloud. Cortex XDR manages XDR agents that are deployed to users endpoints. Cortex XDR Endpoint Verification is deployed as Cloud Functions to your Google Cloud project. Cortex XDR Endpoint Verification calculates the health score for XDR Endpoints based on the severity and the number of the endpoint alerts. Once you enable Cortex XDR Endpoint Verification as a Device Partner’s Service at your Google Admin Site, you will be able to create Access Level at Access Context Manager (ACM) based on Cortex XDR Endpoint Status including if the endpoint is a XDR managed device, if the endpoint is quarantined and the minimum level for the endpoint health score. This enable you to control the application access in IAP using the Cortex XDR Endpoint Access Level you created in ACM.

Please see the [**Deployment Guide**](https://docs.google.com/document/d/1WTmg61OhOGK4CG_ZYXdHXNDK9_H8_R6TlfuJTFKv9uw/edit#) for more information.

</br>
<p align="center">
<img src="https://github.com/wwce/cortex_xdr_bce/blob/460867aabd159becb93253555dfdd5c6564195fe/images/diagram.png">
</p>


### Prerequistes 

#### Google Cloud Platform

* Valid GCP billing account
* Existing GCP project to host the deployment
* Access to GCP Cloud Shell or access to a Terraform 1.0 installation
* Corporate E-Mail address
* Customer ID

#### Palo Alto Networks
* Cortex XDR License
* Cortex XDR Key
* Cortex XDR Key ID


### Deployment Procedure
#### 1. Download Build

##### Step 1a. In your GCP project, open Google Cloud Shell.
<p align="center">
<img src="https://github.com/wwce/cortex_xdr_bce/blob/bcc3fc0504abf40c2054b7cd2c6bb6264c645f0e/images/cloud_shell.png" width="75%" height="75%" >
</p>

##### Step 1b. Clone the build to your Cloud Shell instance.
```
$ git clone https://github.com/wwce/cortex_xdr_bce
```

#### 2. Stage Build
##### Step 2a. Open terraform.tfvars
```
$ nano terraform.tfvars
```
##### Step 2b. Configure Environment Variables
Uncomment the environment variables (lines 5-13) and set values to match your deployment.  The table below describes the expected values for each variable. 

| variable              | value                                                                                                                                                    |
|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| project_id            | Your GCP project ID.                                                                                                                                     |
| xdr_key               | Your Cortex XDR key.                                                                                                                                     |
| xdr_key_id            | Your Cortex XDR key ID.                                                                                                                                  |
| customer_id           | Your GCP customer ID                                                                                                                                     |
| customer_email        | An email address.                                                                                                                                        |
| partner_id            | Your Partner ID.                                                                                                                                         |
| service_account_email | A GCP service account email.                                                                                                                             |
| global_prefix         | A name to prepend to all cloud resources created (i.e. <global_prefix>my-cloud-function)                                                                 |
| project_auth_file     | Only required if you are executing the build outside the deployment project's cloud shell.  You must also uncomment ``line 4`` in main.tf                |

</br>
Your terraform.tfvars file should look like the image below before proceeding. Save your changes (``ctrl+x``).
</br>
</br>

<p align="center">
<img src="https://github.com/wwce/cortex_xdr_bce/blob/460867aabd159becb93253555dfdd5c6564195fe/images/tfvars.png" width="75%" height="75%" >
</p>


#### 3. Deploy Build
```
$ terraform init
$ terraform apply
```


#### 4. Destroy Build (optional)
The following command will remove all resources created during the build.  
```
$ terraform destroy
```


### Support Policy
The guide in this directory and accompanied files are released under an as-is, best effort, support policy. These scripts should be seen as community supported and Palo Alto Networks will contribute our expertise as and when possible. We do not provide technical support or help in using or troubleshooting the components of the project through our normal support options such as Palo Alto Networks support teams, or ASC (Authorized Support Centers) partners and backline support options. The underlying product used (the VM-Series firewall) by the scripts or templates are still supported, but the support is only for the product functionality and not for help in deploying or using the template or script itself.
Unless explicitly tagged, all projects or work posted in our GitHub repository (at https://github.com/PaloAltoNetworks) or sites other than our official Downloads page on https://support.paloaltonetworks.com are provided under the best effort policy.