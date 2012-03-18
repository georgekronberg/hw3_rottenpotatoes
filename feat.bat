@echo off
@del features.tar.gz
@7za a -ttar features.tar features/
@7za a -tgzip features.tar.gz features.tar
@del features.tar
@echo on