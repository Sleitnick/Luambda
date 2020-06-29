![logo](imgs/logo_128.png)

# Luambda

Lua runtime for AWS Lambda.

## Create Layer

```sh
# Executable permissions
chmod +x bootstrap
chmod +x runtime/luajit

# Package and upload to S3:
$ ./package.json
$ aws s3 cp lambda.zip s3://<upload_bucket><upload_prefix>

# Create Lambda Layer:
$ aws cloudformation package --template-file aws/luambda.yaml --s3-bucket <bucket> --s3-prefix <prefix> --output-template-file <output_file>
$ aws cloudformation deploy --template-file <output_file> --s3-bucket <bucket> --s3-prefix <prefix> --stack-name LuambdaLayer --parameter-override S3Bucket=<upload_bucket> S3Key=<upload_prefix>
```

## Use Layer

For your Lambda configuration, add Luambda as a layer.

## Setup

The `Handler` property of your lambda follows the syntax of `[script_name].[function_name]`. The script should return a table that contains that function. For instance, if the handler was set as `test.handler`, then the code would look like this:

```lua
-- test.lua

local test = {}

function test.handler(event)
	return {
		Ok = "All good";
	}
end

return test
```

## Different Lua Versions

By default, Luambda uses [LuaJIT](https://luajit.org/), a JIT compiler for [Lua](https://www.lua.org/). To use a different version, drop in the binaries under `/runtime` and then change the `bootstrap` file to point to the different binary.

For instance, you might change `/opt/runtime/luajit` in the `bootstrap` file to `/opt/runtime/lua51`.

## Third-Party

The following third-party dependencies are used:

- [LuaJIT](https://luajit.org/)
- [`json.lua`](https://github.com/rxi/json.lua) [MIT License]