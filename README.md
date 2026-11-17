# Discoveries, Factoids, and Meandering Thoughts

Source for the blog at <https://saxman.info/blog>, built with [Quartz](https://quartz.jzhao.xyz) v5.

`content/` is both the site's source and an **Obsidian vault**. Open that folder in Obsidian.

## Layout

| Path | Purpose |
| --- | --- |
| `content/posts/` | All posts (`YYYY-MM-DD-topic-subject.md`), including the Blogger archive and new Web Clipper clips. Notes with `draft: true` aren't published |
| `content/drafts/` | New notes from Obsidian. Never published (ignored by Quartz) |
| `content/attachments/` | Images and other files that posts embed |
| `content/templates/` | Obsidian templates. Never published |
| `obsidian-web-clipper/` | Importable Web Clipper templates |
| `scripts/` | `update-clipper-templates.ps1` regenerates the Interpreter templates from the current tags |

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

Post titles start with their top-level topic, e.g. "Language: Hubris" or "Philosophy: Zazen".
Quartz generates a page for every tag, and parent tags list their children (e.g. `/blog/tags/language`).
Before inventing a new tag, check Obsidian's Tags pane and reuse an existing one if it fits.

## Writing workflow

1. **Clip:** use one of the Web Clipper templates in `obsidian-web-clipper/`. The note is saved in `posts/` with `draft: true`.
   - "Blog clipping (excerpt)" and "Blog clipping (summary)" use Web Clipper's Interpreter (an LLM) to write the "Topic: Subject" title, filename and tags, and to quote or summarize the page. Tags are chosen from the tags already used in `posts/`.
   - "Blog clipping" doesn't use the LLM: select a passage first and it's quoted as-is.
   - After adding new tags to posts, run `pwsh scripts/update-clipper-templates.ps1` and re-import the two Interpreter templates.
2. **Edit:** add your own commentary and tags.
3. **Publish:** set `draft: false` (or delete the line), then commit and push. GitHub Actions builds and deploys.

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
