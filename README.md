# Discoveries, Factoids, and Meandering Thoughts

Source for the blog at <https://saxman.info/blog>, built with [Quartz](https://quartz.jzhao.xyz) v5.

`content/` is both the site's source and an **Obsidian vault**. Open that folder in Obsidian.

## Layout

| Path | Purpose |
| --- | --- |
| `content/posts/` | Published posts (`YYYY-MM-DD-slug.md`), including the Blogger archive |
| `content/clippings/` | Obsidian Web Clipper output. These are drafts until edited and published |
| `content/drafts/` | New notes from Obsidian. Never published (ignored by Quartz) |
| `content/attachments/` | Images and other files that posts embed |
| `content/templates/` | Obsidian templates. Never published |
| `obsidian-web-clipper/` | Importable Web Clipper template |
| `scripts/blogger-import/` | One-time Blogger import script and tag mapping |

## Organizing posts

Topics are **nested tags**, not folders, so a post can belong to several topics:

```yaml
tags:
  - language/japanese
  - culture/japan
  - series/word-of-the-day
```

Top-level topics: `philosophy`, `language`, `linguistics`, `culture`, `history`, `religion`, `science`, `mathematics`, `arts`, `food`, `travel`, `folklore`, `humor`, `technology`, `environment`.
Recurring formats live under `series/`: `word-of-the-day`, `phrase-of-the-day`, `philosophy-of-the-day`, `science-of-the-day`, `quotes`, `reading-list`, `photos`.

Quartz generates a page for every tag, and parent tags list their children (e.g. `/blog/tags/language`).
Before inventing a new tag, check Obsidian's Tags pane and reuse an existing one if it fits.

## Writing workflow

1. **Clip:** select a passage on a web page and use the "Blog clipping" Web Clipper template. A note lands in `clippings/` with `draft: true`.
2. **Edit:** add your own commentary and tags.
3. **Publish:** set `draft: false` (or delete the line), optionally move the note to `posts/`, then commit and push. GitHub Actions builds and deploys.

Any note with `draft: true` is excluded from the site, but it is still visible in the GitHub repo if the repo is public.

## Local preview

Requires Node.js 22+.

```sh
npm ci
npx quartz plugin install
npx quartz build --serve   # http://localhost:8080
```

## Updating Quartz

The `upstream` remote points to `jackyzha0/quartz`. Leave `quartz.config.default.yaml` untouched so updates merge cleanly; site settings are in `quartz.config.yaml`.
Local change to Quartz itself: an `index-only` layout condition in `quartz/plugins/loader/conditions.ts`, which shows Recent Posts on the home page only.
