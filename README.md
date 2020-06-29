![Lint](https://github.com/Sleitnick/Luambda/workflows/Lint/badge.svg)

![logo](imgs/logo_128.png)

# Luambda

Lua runtime for AWS Lambda.

Luambda is a [Lambda Layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) that allows developers to write Lambdas using Lua. To get started, read through the rest of this readme.

## Create Layer

```sh
# Clone repo
$ git clone https://github.com/Sleitnick/Luambda
$ cd Luambda

# Executable permissions
$ chmod +x build.sh compile.sh

# Package and upload to S3
$ ./build.json
$ aws s3 cp dist/luambda.zip s3://<upload_bucket>/<optional_path>/luambda.zip

# Create Lambda Layer
$ aws cloudformation create-stack --stack-name LuambdaLayer --template-body file://aws/luambda.yaml --paramters ParameterKey=S3Bucket,ParameterValue=<s3_bucket> ParameterKey=S3Key,ParameterValue=<s3_key>
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

- [LuaJIT](https://luajit.org/) [MIT license]
- [json.lua](https://github.com/rxi/json.lua) [MIT license]