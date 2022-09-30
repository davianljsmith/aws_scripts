#!/bin/bash
set -x	
# Remove ingress rule from default VPCs

#Variables
a=region
b=securitygroupid
c=securityruleid

#Get Region
for i in `aws ec2 describe-regions | awk {' print $4'}`;

do 

#Get Security Group ID
    b=`aws ec2 describe-security-groups --filter Name=group-name,Values=default --region ${i} | grep SECURITYGROUPS | awk {'print $6'}`;

#Get Security Rule ID
    c=`aws ec2 describe-security-group-rules --filter Name="group-id",Values=${b} --region ${i} | grep SECURITYGROUPRULES | grep False | awk {'print $7'}`;

#Delete rule
    aws ec2 revoke-security-group-ingress --group-id ${b} --security-group-rule-ids ${c} --region ${i};

done
