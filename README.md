# Paranode Docs

## Deployment

Paranode Docs is hosted on GitHub pages.

To deploy, create a Pull Request and merge on main to trigger deployment. It will build the website and push to the `gh-pages` branch to deploy it.

## Config

| Key            | Description                  |
| -------------- | ---------------------------- |
| GA_TRACKING_ID | Google Analytics tracking ID |
| DISCORD_INVITE | Discord invitation link      |

## Development

### Installation

```bash
npm i
```

### Local Development

```bash
npm run start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

### Build

```bash
npm run  build
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

# About

This website is built using [Docusaurus 2](https://docusaurus.io/), a modern static website generator.
