CHARTS := $(shell find . -path '*/Chart.yaml' | tr '\n' ' ' | sed -E 's:\./|/Chart\.yaml::g')
DEP_CHARTS := $(shell find . -path '*/requirements.yaml' | tr '\n' ' ' |  sed -E 's:\./|/requirements\.yaml::g')

.PHONY: clean all package makepath copy index sync dependency-update
all: bump-changed package makepath copy index sync clean
prepare: bump-changed
dependency-update:
	helm init -c
	helm repo add pyroclast https://s3.amazonaws.com/charts.pyroclast.io
	$(foreach chart,$(DEP_CHARTS),(helm dependency update --debug $(chart); echo $?) && ) :

package: dependency-update ; $(foreach chart,$(CHARTS),(helm package $(chart) --save=false) &&) :

makepath:
	@mkdir -p pyroclast

copy:
	@aws s3 sync s3://charts.pyroclast.io pyroclast
	@mv *.tgz pyroclast/

index:
	@helm repo index ./pyroclast --url https://s3.amazonaws.com/charts.pyroclast.io

sync:
	@aws s3 sync ./pyroclast s3://charts.pyroclast.io

clean:
	@rm -rf pyroclast

bump-changed: dependency-update
	./bump-changed.sh
