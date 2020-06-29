#!/bin/sh

rm lambda.zip
zip lambda.zip bootstrap runtime/**
#aws lambda update-function-code --function-name lua_test --zip-file fileb://lambda.zip --profile personal_account
