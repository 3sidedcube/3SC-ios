# Swagger Codegen

Scripts to generate a Swift Package from an OpenAPI JSON URL.
It's common to add the `generate.sh` script to your project, updating the configuration variables.
Updating the Swift package would then be as simple as:
```bash
./generate.sh
```

## Remote Script

Run the remote script with the following command:
```bash
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/3sidedcube/3sc-ios/master/generate-with-prompt.sh)"
```

## References

* [swagger-codegen Github](https://github.com/swagger-api/swagger-codegen)
* [swagger.io](https://swagger.io/tools/swagger-codegen/)

