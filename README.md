Task 1: Remote Backend Setup 


 In this i cerated a s3 bucket named terraform-state-lock-bucketonly and i enabled the encryption and versioning while creating. 

And i cerated the dynamo db table which helps me flagging the lock state to terraform 


But when i ran terraform init i face the deprecation warning that is the aws has introduced a new feature it enabled the state file locking in s3 bucket itself and no need of dynamo db so then i removed that and changed to this  
 to  

I did terraform init and was not initialized it asked me to setup valid credentials, there was 2 ways one using cli and other using directly assigning i directly assigned like this 
And Terraform init and was able to successfully initialized the s3 backend


Task 2: Provider & Version Management

In this i added a file called provider.tf to project director and i mentioned the version and region and it can be dynamically changed using variable.tf and every time you ship this code to new region you can change it it variable.tf and can do the provisioning of the resource

    
Provider.tf                                                  variables.tf
We configure the AWS provider with version constraints inside the terraform block using required_providers. The region is injected via variables to make the configuration environment-agnostic. This allows the same codebase to be reused across dev, staging, and prod by simply changing variable values without touching provider configuration.



Task 3: Modular Terraform Design 

I have created the tf files in a modular way so that this can be reused everywhere and created main.tf in such a way thet it only calls the chile modules in it, no resources wer configured there.

 


Task 4: Networking Implementation

For this i changed my directory to cd into vpc in the module of this project and started editing the files i first edited the variables.tf file where i adeed the variables like cidr block and subnet range and availability zones which are ap-south-1a and ap-south-1b 
   
Then i edited the main.tf where the main logic of creating the vpc goes here i referred to the terraform aws public registry and i used chat gpt as well to format my code for internet gateway, public private subnet, nat gateway public private rout tables and their associations 

I wrote outputs.tf file once the resource provisioning is done terraform will give these as the yield outputs after successful creation
I did terraform init nnd the terraform initilized and also when plan i got the statement what it will change 


I did the terraform apply and verified its all created in aws console as well


I verified the state file creation and its version in s3 bucket 


Task 5: Security Groups

This task is to route the traffic from internet to ALB and to ec2 where alb is in public subnet and ec2 is in private subnet to achieve this i need to add tf files both in alb and in compute directory.

I astarted editing the tf’s in alb first, then in compute directory and after that in main or root module i added my machine ip and added terraform.tfvars and edited main.tf as well to triggr this action when i terraform apply





Task 6: Compute Layer 

The goal of this is to make the scaling easy we need to have launch template to make this i created a launch template and approach this to ato acaling 

ALB → Target Group → ASG → EC2 (private)

 


Task 6: Compute Layer 

The goal is to create ec2 launch template so that the application can auto scale using asg which is also will be created in this 

I have configured the files modules/controler , the main.tf with asg and lunch teplet requirements and variables to be red from it and into main and also output.tf for user friendly output show up after completing the creation



AWS ASG





Task 7: Load Balancer 

For thai i edited the smae compute dir files only because the ALB and target groups work in the Compute layer only .


I started editing the main.tf  from the compute and later the output and then i maped the variable with the root s output.tf 



Task 8: IAM Configuration - Create IAM role for EC2 - Attach policies required for application or logging Expected Outcome: No hard-coded credentials in Terraform code. 

I need to create the iam role for ec2 and add them to the i have appende my compute/main.tf with  IAM Role for EC2 and Policy Document to allow EC2 to assume this role and after that i attached the policy to roles 



AWS 


Task 9: Variables & tfvars - Parameterize all environment-specific values - Use terraform.tfvars for configuration Expected Outcome: Same codebase should work for multiple environments

In this i need to make my developed code imto modular and reusable for this im creating terraform.tfvars for different environments like dev qa prod and im passing the variable values which are in the root using tfvars which sits in enach env directory 

I created two dev.tfvars prod.tfvars file and passed values there → and i plan using terraform plan -var-file=”dev.tfvars”→ then i applied using terraform apply -var-file=”dev.tfvars”

In this terraform took lot of time it replaced the old infra setup with new which matches the env im applying for 



Task 10: Environment Separation - Implement dev and prod environments - Use Terraform workspaces or equivalent strategy Expected Outcome: Separate state files for each environment. 

For this i made a logical separation of env that i created in step 9 and moved theme into workspaces i created a directory called env for that 

And migratede with terraform plan migrate then i created the workspace using terraform workspace new dev prod 
As i already have a state in S3 and want to move it to the new workspace-specific path i used 
terraform init -migrate-state

Then i switch to the workspace using terraform workspace select prod and i plan using 
terraform plan -var-file="env/prod.tfvars" and applied using terraform apply -var-file="env/prod.tfvars"



This shows i recreated the infra for my prod environment

Task 11: Lifecycle & Meta-Arguments - Protect critical resources from accidental deletion - Handle replacement safely Expected Outcome: terraform destroy should not remove protected resources

For this i identified some of the resources that i should avoid the destroying when runt terraform destroy and i added the block

 lifecycle {
    prevent_destroy = true
  }
  So this will avoid destroying 

And to avoid replacement safely i have added the 

  lifecycle {
    create_before_destroy = true
  }
  So this will ensure a new resource will be created before destroying and ensure no down time in setting up the infra








Task 13: Outputs - Expose necessary outputs like ALB DNS, VPC ID Expected Outcome: Outputs should be clean and meaningful 

This i was practicing while following the old tasks we can see the outputs when enach resource created 



Task 14: Code Quality - Run terraform fmt and terraform validate - Follow standard Terraform file structure Expected Outcome: Clean, readable, production-grade Terraform code.

Terraform fmt is to tifdey up my code i used terraform fmt -recursive so that the .tf s in my sub folders also get formatted in a good passion

Terraform validate is to validate my edits and this will check the syntex error in the code and report us 







File system fallowed

  

