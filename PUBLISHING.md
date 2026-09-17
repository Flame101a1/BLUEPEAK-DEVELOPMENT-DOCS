# Publish on GitHub Pages

## Upload the documentation project

Commit `docs/`, `mkdocs.yml`, `requirements-docs.txt`, and `.github/workflows/docs.yml` to your GitHub repository. These files also work in a separate documentation-only repository; you do not need to publish your entire resource just to host these pages.

The workflow deploys pushes to `main` or `master`. If your default branch has another name, update the workflow. Pull requests build for validation without deploying.

## Enable Pages

1. Open your repository's **Settings → Pages**.
2. Set **Source** to **GitHub Actions**.
3. Open **Actions → Documentation → Run workflow**, or push a documentation change.
4. Open the site URL reported by the deployment.

No repository URL or custom domain is hard-coded. Relative links support GitHub's repository subpaths. After you know your final address, you may add `site_url` to `mkdocs.yml` for canonical URLs.

## Preview locally

Use Python 3.12 in a virtual environment, from the project directory:

```sh
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
python -m pip install -r requirements-docs.txt
python -m mkdocs serve
```

Open the local address printed by MkDocs. For a production build:

```sh
python -m mkdocs build --strict
```

Generated files go into `site/`. Do not edit generated HTML; edit the Markdown under `docs/` instead. Update the navigation list in `mkdocs.yml` when adding pages.

## Keep the reference accurate

Check signatures and return values against the Lua source whenever changing exports. Client helpers are not a replacement for server authorization. Rebuild with `--strict` before publishing to catch broken documentation links.


## Add another resource

Keep each script's documentation in its own folder. Inventory is the first example:

```text
docs/
  index.md                 # Resource directory
  guides.md                # Cross-resource guide directory
  inventory/
    index.md               # Resource overview
    installation.md
    configuration.md
    functions/
      client.md
      server.md
    guides/
    downloads/
```

For another script, create a sibling folder such as `docs/resource-name/`. Give it an overview and installation guide, then add configuration, functions, and gameplay guides as needed. Do not reuse Inventory's setup instructions or downloads for another resource.

Add a sibling entry to `nav` in `mkdocs.yml`:

```yaml
  - Resource name:
      - Overview: resource-name/index.md
      - Installation: resource-name/installation.md
      - Configuration: resource-name/configuration.md
      - Functions:
          - Client: resource-name/functions/client.md
          - Server: resource-name/functions/server.md
```

The first overview page makes the resource name clickable. The adjacent arrow expands its child pages. Only the active branch opens automatically, so the sidebar stays manageable as the catalog grows.

Add a resource card to `docs/index.md` and links to its guides in `docs/guides.md`. Use relative links to support GitHub Pages repository subpaths. Search indexes all resource pages automatically. Include the resource name in page introductions so search results are easy to distinguish.

## Link from the store

Link the store's documentation button to the published docs home. Link each product's installation or documentation button directly to its resource page, for example `<docs-base-url>/inventory/` or `<docs-base-url>/inventory/installation/`.

Set `site_url` in `mkdocs.yml` once the public docs address is known. No store URL is configured yet. Add a real store link when the destination is available; do not publish a placeholder checkout or store link.

Maintainer instructions belong in this file, outside the customer-facing documentation.
