# charts
Helm charts and images for Pyroclast

To change, edit your chart and bump the version.

To push up the charts
```
cd charts
make all
```

Then update the requirements in your main repo and run:
```
helm deps update
```
