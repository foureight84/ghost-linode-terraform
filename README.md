## Ghost Blog Deployment on Linode using Terraform<br/>...with remote backup using rclone


<pre>
<b>[..root]</b>
│  cloudflare.tf                   //resource module for CloudFlare rules
│  data.tf                         //templating handling ex. docker-compose.yaml, scripts, etc...
│  linode.tf                       //resource module for Linode instance setup
│  outputs.tf                      //handle specific data to display after terraforming
│  providers.tf                    //tokens, auth keys, etc required by service providers
│  terraform.tfvars.example        //example definitions for inputs required for terraforming
│  variables.tf                    //defined inputs required for terraforming
│  versions.tf                     //declaration of providers and versions to use
│
└─<b>[scripts]</b>
  ├─<b>[linode]</b>
  │       docker-compose.yaml      //main stack. nginx proxy, letsencrypt, ghost
  │       stackscript.sh           //boot time script specific to Linode to setup env
  │
  └─<b>[rclone]</b>
    │     backup.sh                //cron script for backing up ghost blog directory
    │     docker-compose.yaml      //rclone docker application
    │
    └──<b>[config]</b>
            rclone.conf.example    //rclone generated configuration for cloud storage
</pre>

### Usage

```
cp terraform.tfvars.example defined.tfvars
```
Fill out `defined.tfvars` with necessary values for deployment.

```
terraform init
```

To use rclone with deployment, checkout `README.md` in the `rclone` and `rclone\config` folders for necessary changes to match your setup and flag rclone key in `defined.tfvars` to true.

To create execution plan and preview changes:
```
terraform plan -var-file="defined.tfvars"
```

To deploy:
```
terraform apply -var-file="defined.tfvars"
```