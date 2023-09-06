# Swagger Codegen

Scripts to generate API code for a Swift Package from an OpenAPI JSON URL.
The [swagger-codegen](https://github.com/swagger-api/swagger-codegen) command must be installed before running (can be done with Homebrew).

## Usage

1. Make a new [Local Swift Package](https://developer.apple.com/documentation/xcode/organizing-your-code-with-local-packages) in your project, following these instructions
2. Ensure [Alamofire](https://github.com/Alamofire/Alamofire) is added as a package dependency
3. Add the [generate-swift-package.sh](https://github.com/3sidedcube/3SC-ios/blob/master/swagger-codegen/generate-swift-package.sh) to the (main) project for quick use
4. Update the configuration variables at the top of this script accordingly
5. Run the script to populate the API Swift Package `./generate-swift-package.sh`

Alternatively, if you prefer the script prompts for input, run:
```bash
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/develop/SwaggerCodegen/generate.sh)"
```

## Other References

* [swagger.io](https://swagger.io/tools/swagger-codegen/)

