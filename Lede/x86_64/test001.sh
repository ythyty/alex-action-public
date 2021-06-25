#!/bin/bash
cd openwrt
sudo mkdir -p ./artifact/firmware
sudo mkdir -p ./artifact/package
sudo mkdir -p ./artifact/package_tmp
sudo mkdir -p ./artifact/buildinfo

df -hT $PWD
ls

# rm -rf $(find ./bin/targets/ -type d -name "packages")

sudo cp -rf $(find ./bin/targets/ -type f) ./artifact/firmware/
sudo cp -rf $(find ./bin/packages/ -type f -name "*.ipk") ./artifact/package_tmp/
sudo cp -rf $(find ./bin/targets/ -type f -name "*.buildinfo" -o -name "*.manifest") ./artifact/buildinfo/

sudo tar -zcvf ./artifact/packages/packages.tar.gz ./artifact/package_tmp/*
sudo rm -rf ./artifact/package_tmp

echo "FIRMWARE=$PWD" >> $GITHUB_ENV
echo "::set-output name=status::success"