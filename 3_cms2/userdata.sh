yum install -y puppet

mkdir /puppet
aws s2 cp s3://cmaas.dev.resources/infrastructure/puppet/ /puppet --region us-east-1

puppet apply --modulepath=/puppet/modules  /puppet/manifests/default.pp