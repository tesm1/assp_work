
# How to use

## Simulation with proxim/ttasim
1. Copy osal defintion files to its location
```bash
cp osal/* /home/user/.tce/opset/custom/
```
2. open osed and build
```bash
osed &
```

## Simulation with fpga
### Make sure paths are correct
- check mymac.hdb
```bash
hdbeditor &
```
- check prosessor.idf
```bash
prode processor.adf
```