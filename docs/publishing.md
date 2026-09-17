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

