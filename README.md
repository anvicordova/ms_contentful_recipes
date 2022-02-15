# README

## Apps info
 * Rails app runs in port 3000 (using this default config)

## Docker Installation

1. Install dependencies
```
https://www.docker.com/products/docker-desktop
```

2. Clone repository
3. cd into repository folder

4. Create env files for rails
```
cp .env.example .env
```

5. Run
```
docker-compose up
```

## Endpoints

### GET recipes

```curl
curl --location --request GET 'http://localhost:3000/recipes'
```

### GET recipes/:id

Uses the contentful id to query a recipe

```curl
curl --location --request GET 'http://localhost:3000/recipes/437eO3ORCME46i02SeCW46'
```

## Implementation notes

1. `HttpClient` is a class to handle http requests

2. Created a custom client to manage contentful requests: `Contentful::Client` that will return the response from the contentful API in a `Contentful::Response`

3. Created a `Contentful::ResponseHandler` to map the responses of the Contentful API to appropiate errors to be handled by this application.

4. `RecipesBuilder` will build a `Recipe`, `Photo`, `Chef` or `Tag` object from the json response of the Contentful API

## Testing

1. Mocking the requests with VCR.