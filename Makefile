STACK_NAME := hashcat
KEY_NAME := aws
REGION := us-east-1
CMD_CLOUDFORMATION := aws cloudformation --region $(REGION)

.PHONY: create
create:
	$(CMD_CLOUDFORMATION) create-stack --stack-name $(STACK_NAME) --parameters ParameterKey=paramKeyPair,ParameterValue=$(KEY_NAME) --template-body file://hashcat.yaml

.PHONY: delete
delete:
	$(CMD_CLOUDFORMATION) delete-stack --stack-name $(STACK_NAME)

.PHONY: describe
describe:
	$(CMD_CLOUDFORMATION) describe-stacks --stack-name $(STACK_NAME)

.PHONY: get_status
get_status:
	$(CMD_CLOUDFORMATION) describe-stacks --stack-name $(STACK_NAME) | jq -r '.Stacks[0].StackStatus'

.PHONY: get_ip
get_ip:
	$(CMD_CLOUDFORMATION) describe-stacks --stack-name $(STACK_NAME) | jq -r '.Stacks[0].Outputs | map(select(.OutputKey | contains ("PublicIp")))[0].OutputValue'
