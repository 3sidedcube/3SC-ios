# Swagger Codegen

Scripts to generate a Swift Package from an OpenAPI JSON URL.

## Usage

1. Add the `generate-swift-package.sh` to your project
2. Update the configuration variables at the top of the script accordingly
3. Run the script to generate the API Swift Package `./generate-swift-package.sh`

Alternatively, if you prefer the script to prompt for input, run:
```bash
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/swagger-codegen/generate.sh)"
```

## References

* [swagger-codegen Github](https://github.com/swagger-api/swagger-codegen)
* [swagger.io](https://swagger.io/tools/swagger-codegen/)

